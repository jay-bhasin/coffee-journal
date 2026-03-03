import 'package:coffee_journal/core/db/database_provider.dart';
import 'package:coffee_journal/core/models/enums.dart';
import 'package:coffee_journal/core/models/recipe_step_draft.dart';
import 'package:coffee_journal/core/repositories/contracts.dart';
import 'package:coffee_journal/core/utils/unit_converter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class EntryListScreen extends ConsumerStatefulWidget {
  const EntryListScreen({super.key, required this.coffeeId});

  final String coffeeId;

  @override
  ConsumerState<EntryListScreen> createState() => _EntryListScreenState();
}

class _EntryListScreenState extends ConsumerState<EntryListScreen> {
  EntrySortOption _sort = EntrySortOption.starredNewest;
  String? _method;
  bool _starredOnly = false;
  bool _showSortControls = false;
  final _tagController = TextEditingController();

  @override
  void dispose() {
    _tagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final coffeeRepository = ref.watch(coffeeRepositoryProvider);
    final entryRepository = ref.watch(entryRepositoryProvider);
    final templateRepository = ref.watch(templateRepositoryProvider);
    final scaler = ref.watch(recipeScalerProvider);
    final brewMethodsRepo = ref.watch(brewMethodRepositoryProvider);
    final unitSystem = ref.watch(unitSystemProvider).valueOrNull ?? UnitSystem.metric;
    final unitConverter = ref.watch(unitConverterProvider);

    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder(
          future: coffeeRepository.getById(widget.coffeeId),
          builder: (context, snapshot) {
            final name = snapshot.data?.coffee.name;
            return Text(name == null ? 'Entries' : '$name entries');
          },
        ),
        actions: [
          IconButton(
            tooltip: _showSortControls ? 'Hide sorting and filters' : 'Show sorting and filters',
            onPressed: () => setState(() => _showSortControls = !_showSortControls),
            icon: Icon(_showSortControls ? Icons.tune : Icons.sort),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await context.push('/coffee/${widget.coffeeId}/entry/new');
          if (mounted) setState(() {});
        },
        icon: const Icon(Icons.add),
        label: const Text('Entry'),
      ),
      body: Column(
        children: [
          if (_showSortControls)
            Padding(
              padding: const EdgeInsets.all(12),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  DropdownButton<EntrySortOption>(
                    value: _sort,
                    onChanged: (v) => setState(() => _sort = v ?? _sort),
                    items: EntrySortOption.values
                        .map((e) => DropdownMenuItem(value: e, child: Text(_entrySortLabel(e))))
                        .toList(),
                  ),
                  FutureBuilder<List<BrewMethodOption>>(
                    future: brewMethodsRepo.list(),
                    builder: (context, snapshot) {
                      final methods = snapshot.data ?? const <BrewMethodOption>[];
                      return DropdownButton<String?>(
                        value: _method,
                        hint: const Text('Method'),
                        onChanged: (v) => setState(() => _method = v),
                        items: [
                          const DropdownMenuItem<String?>(value: null, child: Text('All methods')),
                          ...methods.map(
                            (m) => DropdownMenuItem<String?>(value: m.name, child: Text(m.name)),
                          ),
                        ],
                      );
                    },
                  ),
                  FilterChip(
                    label: const Text('Starred only'),
                    selected: _starredOnly,
                    onSelected: (v) => setState(() => _starredOnly = v),
                  ),
                  SizedBox(
                    width: 180,
                    child: TextField(
                      controller: _tagController,
                      decoration: const InputDecoration(
                        hintText: 'Filter tag',
                        isDense: true,
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            child: FutureBuilder<List<EntryRecord>>(
              future: entryRepository.listForCoffee(
                widget.coffeeId,
                sort: _sort,
                filter: EntryFilter(
                  method: _method,
                  starredOnly: _starredOnly,
                  tag: _tagController.text.trim().isEmpty ? null : _tagController.text,
                ),
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final items = snapshot.data ?? [];
                if (items.isEmpty) {
                  return const Center(child: Text('No entries yet. Add your first brew entry.'));
                }

                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final record = items[index];
                    final entry = record.entry;
                    final ratio = scaler.computeRatio(
                      coffeeDoseG: entry.coffeeDoseG,
                      waterTotalG: entry.waterTotalG,
                    );
                    final brewTime = entry.brewTimeSecManual ?? entry.brewTimeSecAuto;
                    final tempLabel = _formatTemperature(entry.waterTempC, unitSystem, unitConverter);
                    final grinderLabel = _formatGrinder(entry.grinder, entry.grindSetting);

                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: ListTile(
                        title: Text(
                          '${DateFormat.yMMMd().add_Hm().format(entry.brewAt)} • ${entry.brewMethod}',
                        ),
                        subtitle: Text(
                          '${_formatWeight(entry.coffeeDoseG)} / '
                          '${_formatWeight(entry.waterTotalG)} '
                          '(1:${ratio.toStringAsFixed(1)}) • '
                          '${tempLabel ?? '-'} • '
                          '${grinderLabel ?? '-'} • '
                          '${_formatDuration(brewTime)}',
                        ),
                        leading: entry.isStarred
                            ? const Icon(Icons.star, color: Colors.amber)
                            : const Icon(Icons.coffee),
                        trailing: PopupMenuButton<String>(
                          onSelected: (v) async {
                            switch (v) {
                              case 'toggle_star':
                                await entryRepository.upsert(
                                id: entry.id,
                                coffeeId: entry.coffeeId,
                                brewAt: entry.brewAt,
                                brewMethod: entry.brewMethod,
                                  isStarred: !entry.isStarred,
                                  coffeeDoseG: entry.coffeeDoseG,
                                  waterTotalG: entry.waterTotalG,
                                  waterTempC: entry.waterTempC,
                                  grinder: entry.grinder,
                                  grindSetting: entry.grindSetting,
                                  yieldG: entry.yieldG,
                                  pressureBar: entry.pressureBar,
                                  preinfusionSec: entry.preinfusionSec,
                                  brewTimeSecAuto: entry.brewTimeSecAuto,
                                  brewTimeSecManual: entry.brewTimeSecManual,
                                  sensoryJson: entry.sensoryJson,
                                  dialInNotes: entry.dialInNotes,
                                  miscNotes: entry.miscNotes,
                                  agitationLevel: entry.agitationLevel,
                                  drawdownSec: entry.drawdownSec,
                                  extractionOutcome: ExtractionOutcome.values.firstWhere(
                                    (e) => e.name == entry.extractionOutcome,
                                    orElse: () => ExtractionOutcome.unknown,
                                  ),
                                  steps: record.steps
                                      .map(
                                        (s) => RecipeStepDraft(
                                          type: RecipeStepType.values.firstWhere(
                                            (e) => e.name == s.type,
                                            orElse: () => RecipeStepType.custom,
                                          ),
                                          index: s.stepIndex,
                                          startSec: s.startSec,
                                          durationSec: s.durationSec,
                                          note: s.note,
                                          waterG: s.waterG,
                                          flowRateGPerSec: s.flowRateGPerSec,
                                          pressureBar: s.pressureBar,
                                          count: s.count,
                                          tool: s.tool,
                                          label: s.label,
                                          jsonPayload: s.jsonPayload,
                                        ),
                                      )
                                      .toList(),
                                  tags: record.tags,
                                );
                                break;
                              case 'duplicate':
                                await entryRepository.duplicateEntryToNewDay(
                                  entry.id,
                                  DateTime.now(),
                                );
                                break;
                              case 'edit':
                                if (!context.mounted) return;
                                await context.push('/coffee/${widget.coffeeId}/entry/${entry.id}/edit');
                                break;
                              case 'delete':
                                await entryRepository.delete(entry.id);
                                break;
                              case 'create_template':
                                final defaultName =
                                    '${entry.brewMethod} ${DateFormat.yMMMd().format(entry.brewAt)}';
                                final name = await _promptTemplateName(context, defaultName);
                                if (name == null || name.trim().isEmpty) break;
                                await templateRepository.upsert(
                                  name: name.trim(),
                                  scope: TemplateScope.global,
                                  coffeeId: null,
                                  brewMethod: entry.brewMethod,
                                  defaultCoffeeDoseG: entry.coffeeDoseG,
                                  defaultWaterTotalG: entry.waterTotalG,
                                  steps: record.steps
                                      .map(
                                        (s) => RecipeStepDraft(
                                          type: RecipeStepType.values.firstWhere(
                                            (e) => e.name == s.type,
                                            orElse: () => RecipeStepType.custom,
                                          ),
                                          index: s.stepIndex,
                                          startSec: s.startSec,
                                          durationSec: s.durationSec,
                                          note: s.note,
                                          waterG: s.waterG,
                                          flowRateGPerSec: s.flowRateGPerSec,
                                          pressureBar: s.pressureBar,
                                          count: s.count,
                                          tool: s.tool,
                                          label: s.label,
                                          jsonPayload: s.jsonPayload,
                                        ),
                                      )
                                      .toList(),
                                  tags: record.tags,
                                );
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Template created')),
                                  );
                                }
                                break;
                            }
                            if (mounted) setState(() {});
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 'toggle_star',
                              child: Text(entry.isStarred ? 'Unstar' : 'Star'),
                            ),
                            const PopupMenuItem(value: 'duplicate', child: Text('Duplicate as today')),
                            const PopupMenuItem(value: 'edit', child: Text('Edit')),
                            const PopupMenuItem(
                              value: 'create_template',
                              child: Text('Create template from entry'),
                            ),
                            const PopupMenuItem(value: 'delete', child: Text('Delete')),
                          ],
                        ),
                        onTap: () async {
                          await context.push('/entry/${entry.id}');
                          if (mounted) setState(() {});
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _entrySortLabel(EntrySortOption sort) {
    switch (sort) {
      case EntrySortOption.starredNewest:
        return 'Starred + newest';
      case EntrySortOption.newest:
        return 'Newest';
      case EntrySortOption.oldest:
        return 'Oldest';
      case EntrySortOption.method:
        return 'Method';
    }
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  String _formatWeight(double grams) => '${grams.toStringAsFixed(1)} g';

  String? _formatTemperature(
    double? celsius,
    UnitSystem unitSystem,
    UnitConverter unitConverter,
  ) {
    if (celsius == null) return null;
    if (unitSystem == UnitSystem.imperial) {
      return '${unitConverter.cToF(celsius).toStringAsFixed(0)}\u00b0 F';
    }
    return '${celsius.toStringAsFixed(0)}\u00b0 C';
  }

  String? _formatGrinder(String? grinder, String? grindSetting) {
    final g = grinder?.trim();
    final s = grindSetting?.trim();
    final hasG = g != null && g.isNotEmpty;
    final hasS = s != null && s.isNotEmpty;
    if (!hasG && !hasS) return null;
    if (hasG && hasS) return '$g • $s';
    return hasG ? g : s;
  }

  Future<String?> _promptTemplateName(BuildContext context, String initialName) async {
    final controller = TextEditingController(text: initialName);
    final value = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Template name'),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(
              labelText: 'Name',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(controller.text),
              child: const Text('Create'),
            ),
          ],
        );
      },
    );
    controller.dispose();
    return value;
  }
}
