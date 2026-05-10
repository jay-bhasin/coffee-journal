import 'package:coffee_journal/core/db/database_provider.dart';
import 'package:coffee_journal/core/models/enums.dart';
import 'package:coffee_journal/core/repositories/contracts.dart';
import 'package:coffee_journal/core/utils/display_formatters.dart';
import 'package:coffee_journal/features/coffees/widgets/coffee_summary_card.dart';
import 'package:coffee_journal/features/entries/entry_actions.dart';
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
    ref.watch(appDataRevisionProvider);
    final coffeeRepository = ref.watch(coffeeRepositoryProvider);
    final entryRepository = ref.watch(entryRepositoryProvider);
    final templateRepository = ref.watch(templateRepositoryProvider);
    final scaler = ref.watch(recipeScalerProvider);
    final brewMethodsRepo = ref.watch(brewMethodRepositoryProvider);
    final displayFormatter = ref.watch(appDisplayFormatterProvider);
    final coffeeFuture = coffeeRepository.getById(widget.coffeeId);

    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder(
          future: coffeeFuture,
          builder: (context, snapshot) {
            return const Text('Entries');
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
            final templateId = await context.push<String>('/templates?picker=1');
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
                    return CoffeeSummaryCard(record: record);
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
                      final tempLabel = displayFormatter.formatTemperature(entry.waterTempC);
                      final grinderLabel = DisplayFormatters.formatGrinder(
                        entry.grinder,
                        entry.grindSetting,
                      );
                      final extractionOutcome = DisplayFormatters.formatExtractionOutcome(
                        entry.extractionOutcome
                      );

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Card.filled(
                          color: Theme.of(context).colorScheme.surfaceContainerLow,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.fromLTRB(14, 12, 8, 12),
                            title: Text(
                              DateFormat.yMMMd().add_Hm().format(entry.brewAt),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${displayFormatter.formatWeight(entry.coffeeDoseG)} / '
                                    '${displayFormatter.formatWeight(entry.waterTotalG)} '
                                    '(1:${ratio.toStringAsFixed(1)})',
                                  ),
                                  Text(
                                    <String?>[
                                      tempLabel,
                                      grinderLabel,
                                      DisplayFormatters.formatDuration(brewTime),
                                    ].whereType<String>().join(' • '),
                                  ),
                                  const SizedBox(height: 10),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 6,
                                    children: [
                                      Chip(
                                        visualDensity: VisualDensity.compact,
                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        labelPadding: const EdgeInsets.symmetric(horizontal: 6),
                                        label: Text(entry.brewMethod),
                                      ),
                                      if (entry.extractionOutcome != ExtractionOutcome.unknown.name)
                                        Chip(
                                          visualDensity: VisualDensity.compact,
                                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          labelPadding: const EdgeInsets.symmetric(horizontal: 6),
                                          avatar: Icon(DisplayFormatters.extractionOutcomeIcon(entry.extractionOutcome), size: 18),
                                          label: Text(extractionOutcome),
                                        ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            leading: IconButton(
                              tooltip: entry.isStarred ? 'Unstar entry' : 'Star entry',
                              onPressed: () async {
                                await EntryActions.toggleStar(entryRepository, record);
                                if (mounted) setState(() {});
                              },
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(
                                minWidth: 32,
                                minHeight: 32,
                              ),
                              visualDensity: VisualDensity.compact,
                              icon: Icon(
                                entry.isStarred ? Icons.star : Icons.star_border,
                                color: entry.isStarred ? Colors.amber : null,
                              ),
                            ),
                            trailing: PopupMenuButton<String>(
                          onSelected: (v) async {
                            switch (v) {
                              case 'duplicate':
                                await EntryActions.duplicateAsToday(entryRepository, entry.id);
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
                                  final steps = EntryActions.stepDraftsFromSteps(record.steps);

                                  await templateRepository.upsert(
                                    name: name.trim(),
                                    scope: TemplateScope.global,
                                    coffeeId: null,
                                    brewMethod: entry.brewMethod,
                                    defaultCoffeeDoseG: entry.coffeeDoseG,
                                    defaultWaterTotalG: entry.waterTotalG,
                                    steps: steps,
                                    tags: const [],
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
}
