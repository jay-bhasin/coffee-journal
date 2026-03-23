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
  bool _showSortControls = false;

  @override
  Widget build(BuildContext context) {
    final coffeeRepository = ref.watch(coffeeRepositoryProvider);
    final entryRepository = ref.watch(entryRepositoryProvider);
    final templateRepository = ref.watch(templateRepositoryProvider);
    final scaler = ref.watch(recipeScalerProvider);
    final brewMethodsRepo = ref.watch(brewMethodRepositoryProvider);
    final unitSystem = ref.watch(unitSystemProvider).maybeWhen(
          data: (value) => value,
          orElse: () => UnitSystem.metric,
        );
    final unitConverter = ref.watch(unitConverterProvider);
    final coffeeFuture = coffeeRepository.getById(widget.coffeeId);

    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder(
          future: coffeeFuture,
          builder: (context, snapshot) {
            final name = snapshot.data?.coffee.name;
            return Text(name == null ? 'Entries' : name);
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
          final action = await _showCreateEntryOptions(context);
          if (!context.mounted || action == null) return;

          if (action == 'blank') {
            await context.push('/coffee/${widget.coffeeId}/entry/new');
          } else if (action == 'template') {
            final templateId = await _selectTemplateId(context, templateRepository);
            if (!context.mounted || templateId == null) return;
            await context.push('/coffee/${widget.coffeeId}/entry/new?templateId=$templateId');
          }
          if (mounted) setState(() {});
        },
        icon: const Icon(Icons.add),
        label: const Text('Entry'),
      ),
      body: FutureBuilder<List<EntryRecord>>(
        future: entryRepository.listForCoffee(
          widget.coffeeId,
          sort: _sort,
          filter: EntryFilter(
            method: _method,
          ),
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final items = snapshot.data ?? [];

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: FutureBuilder<CoffeeRecord?>(
                  future: coffeeFuture,
                  builder: (context, snapshot) {
                    final record = snapshot.data;
                    if (record == null) return const SizedBox.shrink();
                    final coffee = record.coffee;
                    final location = _formatLocation(coffee.region, coffee.country);
                    final metaChips = <String>[
                      if (!_isBlank(location)) location!,
                      if (!_isBlank(coffee.varietal)) coffee.varietal!,
                      if (!_isBlank(coffee.process)) coffee.process!,
                    ];
                    final detailLine = <String>[
                      if (!_isBlank(coffee.altitudeM)) 'Altitude: ${coffee.altitudeM!}',
                      if (coffee.roastDate != null)
                        'Roast ${DateFormat.yMMMd().format(coffee.roastDate!)}',
                      if (record.tags.isNotEmpty) 'Tags: ${record.tags.join(', ')}',
                    ].join(' • ');
                    return Container(
                      margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            coffee.roaster,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          if (metaChips.isNotEmpty) ...[
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 6,
                              runSpacing: 6,
                              children: metaChips
                                  .map(
                                    (value) => Chip(
                                      visualDensity: VisualDensity.compact,
                                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      labelPadding: const EdgeInsets.symmetric(horizontal: 6),
                                      label: Text(value),
                                    ),
                                  )
                                  .toList(growable: false),
                            ),
                          ],
                          if (!_isBlank(coffee.tastingNotes)) ...[
                            const SizedBox(height: 8),
                            Text(
                              coffee.tastingNotes!,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                          if (detailLine.isNotEmpty) ...[
                            const SizedBox(height: 8),
                            Text(
                              detailLine,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: AnimatedSize(
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOut,
                  child: _showSortControls
                      ? Container(
                          margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surfaceContainerHigh,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              DropdownButton<EntrySortOption>(
                                value: _sort,
                                onChanged: (v) => setState(() => _sort = v ?? _sort),
                                items: EntrySortOption.values
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(_entrySortLabel(e)),
                                      ),
                                    )
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
                                      const DropdownMenuItem<String?>(
                                        value: null,
                                        child: Text('All methods'),
                                      ),
                                      ...methods.map(
                                        (m) => DropdownMenuItem<String?>(
                                          value: m.name,
                                          child: Text(m.name),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'All Entries (${items.length})',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const Spacer(),
                          Chip(
                            visualDensity: VisualDensity.compact,
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            labelPadding: const EdgeInsets.symmetric(horizontal: 6),
                            avatar: const Icon(Icons.sort, size: 18),
                            label: Text(_entrySortLabel(_sort)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (_method != null)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: [
                              if (_method != null)
                                Chip(
                                  visualDensity: VisualDensity.compact,
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  labelPadding: const EdgeInsets.symmetric(horizontal: 6),
                                  label: Text('Method: $_method'),
                                  onDeleted: () => setState(() => _method = null),
                                ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              if (items.isEmpty)
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Text('No entries yet. Add your first brew entry.'),
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 96),
                  sliver: SliverList.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final record = items[index];
                      final entry = record.entry;
                      final ratio = scaler.computeRatio(
                        coffeeDoseG: entry.coffeeDoseG,
                        waterTotalG: entry.waterTotalG,
                      );
                      final brewTime = entry.brewTimeSecManual ?? entry.brewTimeSecAuto;
                      final tempLabel = _formatTemperature(
                        entry.waterTempC,
                        unitSystem,
                        unitConverter,
                      );
                      final grinderLabel = _formatGrinder(entry.grinder, entry.grindSetting);

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Card.filled(
                          color: Theme.of(context).colorScheme.surfaceContainerLow,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.fromLTRB(14, 10, 8, 10),
                            title: Text(
                              DateFormat.yMMMd().add_Hm().format(entry.brewAt),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${_formatWeight(entry.coffeeDoseG)} / ${_formatWeight(entry.waterTotalG)} '
                                    '(1:${ratio.toStringAsFixed(1)})',
                                  ),
                                  Text(
                                    <String?>[
                                      tempLabel,
                                      grinderLabel,
                                      _formatDuration(brewTime),
                                    ].whereType<String>().join(' • '),
                                  ),
                                  const SizedBox(height: 6),
                                  Chip(
                                    visualDensity: VisualDensity.compact,
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    labelPadding: const EdgeInsets.symmetric(horizontal: 6),
                                    label: Text(entry.brewMethod),
                                  ),
                                ],
                              ),
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
                                try {
                                  final defaultName =
                                      '${entry.brewMethod} ${DateFormat.yMMMd().format(entry.brewAt)}';
                                  final name = await _promptTemplateName(context, defaultName);
                                  if (name == null || name.trim().isEmpty) break;
                                  final steps = record.steps
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
                                      .toList(growable: false);
                                  final tags = record.tags
                                      .map((e) => e.trim())
                                      .where((e) => e.isNotEmpty)
                                      .toSet()
                                      .toList(growable: false);

                                  await templateRepository.upsert(
                                    name: name.trim(),
                                    scope: TemplateScope.global,
                                    coffeeId: null,
                                    brewMethod: entry.brewMethod,
                                    defaultCoffeeDoseG: entry.coffeeDoseG,
                                    defaultWaterTotalG: entry.waterTotalG,
                                    steps: steps,
                                    tags: tags,
                                  );
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Template created')),
                                    );
                                  }
                                } catch (error, stackTrace) {
                                  debugPrint('Create template failed: $error');
                                  debugPrintStack(stackTrace: stackTrace);
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Template creation failed: $error')),
                                    );
                                  }
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
                            const PopupMenuItem(value: 'duplicate', child: Text('Duplicate')),
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
                        ),
                      );
                    },
                  ),
                ),
            ],
          );
        },
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
    if (hasG && hasS) return '$s ($g)';
    return hasS ? s : g;
  }

  String? _formatLocation(String? region, String? country) {
    final r = region?.trim();
    final c = country?.trim();
    final hasR = r != null && r.isNotEmpty;
    final hasC = c != null && c.isNotEmpty;
    if (!hasR && !hasC) return null;
    if (hasR && hasC) return '$r, $c';
    return hasR ? r : c;
  }

  bool _isBlank(String? value) => value == null || value.trim().isEmpty;

  Future<String?> _promptTemplateName(BuildContext context, String initialName) async {
    var draftName = initialName;
    final value = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Template name'),
          content: TextFormField(
            initialValue: initialName,
            autofocus: true,
            onChanged: (value) => draftName = value,
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
              onPressed: () => Navigator.of(context).pop(draftName),
              child: const Text('Create'),
            ),
          ],
        );
      },
    );
    return value;
  }

  Future<String?> _showCreateEntryOptions(BuildContext context) {
    return showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.edit_note),
                title: const Text('Blank entry'),
                subtitle: const Text('Start from an empty entry form'),
                onTap: () => Navigator.of(context).pop('blank'),
              ),
              ListTile(
                leading: const Icon(Icons.description_outlined),
                title: const Text('From template'),
                subtitle: const Text('Prefill entry from a saved recipe template'),
                onTap: () => Navigator.of(context).pop('template'),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<String?> _selectTemplateId(
    BuildContext context,
    TemplateRepository repository,
  ) async {
    final templates = await repository.list();
    if (templates.isEmpty) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No templates found. Create one from Settings > Recipe templates.')),
        );
      }
      return null;
    }
    if (!context.mounted) return null;

    return showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: templates.length,
            itemBuilder: (context, index) {
              final record = templates[index];
              final template = record.template;
              final dose = template.defaultCoffeeDoseG?.toStringAsFixed(1) ?? '-';
              final water = template.defaultWaterTotalG?.toStringAsFixed(1) ?? '-';
              return ListTile(
                leading: const Icon(Icons.description_outlined),
                title: Text(template.name),
                subtitle: Text('${template.brewMethod} • $dose g / $water g • ${record.steps.length} steps'),
                onTap: () => Navigator.of(context).pop(template.id),
              );
            },
          ),
        );
      },
    );
  }
}
