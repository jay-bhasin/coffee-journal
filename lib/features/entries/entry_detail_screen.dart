import 'dart:convert';

import 'package:coffee_journal/core/db/database.dart';
import 'package:coffee_journal/core/db/database_provider.dart';
import 'package:coffee_journal/core/models/enums.dart';
import 'package:coffee_journal/core/models/sensory_notes.dart';
import 'package:coffee_journal/core/repositories/contracts.dart';
import 'package:coffee_journal/core/utils/display_formatters.dart';
import 'package:coffee_journal/features/coffees/widgets/coffee_summary_card.dart';
import 'package:coffee_journal/features/entries/entry_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class EntryDetailScreen extends ConsumerStatefulWidget {
  const EntryDetailScreen({super.key, required this.entryId});

  final String entryId;

  @override
  ConsumerState<EntryDetailScreen> createState() => _EntryDetailScreenState();
}

class _EntryDetailScreenState extends ConsumerState<EntryDetailScreen> {
  int _refreshToken = 0;

  @override
  Widget build(BuildContext context) {
    final repository = ref.watch(entryRepositoryProvider);
    final coffeeRepository = ref.watch(coffeeRepositoryProvider);
    final templateRepository = ref.watch(templateRepositoryProvider);
    final unitSystem = ref.watch(unitSystemProvider).maybeWhen(
          data: (value) => value,
          orElse: () => UnitSystem.metric,
        );
    final unitConverter = ref.watch(unitConverterProvider);

    return FutureBuilder<EntryRecord?>(
      key: ValueKey('entry-detail-${widget.entryId}-$_refreshToken'),
      future: repository.getById(widget.entryId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(title: const Text('Entry detail')),
            body: const Center(child: CircularProgressIndicator()),
          );
        }
        final item = snapshot.data;
        if (item == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Entry detail')),
            body: const Center(child: Text('Entry not found')),
          );
        }
        final entry = item.entry;
        final coffeeFuture = coffeeRepository.getById(entry.coffeeId);
        final sensory = entry.sensoryJson == null
            ? null
            : SensoryNotes.fromJson(jsonDecode(entry.sensoryJson!) as Map<String, dynamic>);
        final brewTime = entry.brewTimeSecManual ?? entry.brewTimeSecAuto;
        final ratio = entry.coffeeDoseG <= 0 ? 0.0 : entry.waterTotalG / entry.coffeeDoseG;
        final temperature = DisplayFormatters.formatTemperature(
          entry.waterTempC,
          unitSystem,
          unitConverter,
        );
        final grinder = DisplayFormatters.formatGrinder(
          entry.grinder,
          entry.grindSetting,
        );

        return Scaffold(
          appBar: AppBar(
            // title: const Text('Entry'),
            actions: [
              SizedBox.square(
                dimension: 48,
                child: IconButton(
                  tooltip: entry.isStarred ? 'Unstar entry' : 'Star entry',
                  onPressed: () async {
                    await EntryActions.toggleStar(repository, item);
                    setState(() => _refreshToken++);
                  },
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    size: 24,
                    entry.isStarred ? Icons.star : Icons.star_border,
                    color: entry.isStarred ? Colors.amber : null,
                  ),
                ),
              ),
              SizedBox.square(
                dimension: 48,
                child: IconButton(
                  tooltip: 'Edit',
                  onPressed: () async {
                    if (!context.mounted) return;
                    await context.push('/coffee/${entry.coffeeId}/entry/${entry.id}/edit');
                    if (mounted) setState(() => _refreshToken++);
                  },
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.edit_outlined, size:24),
                ),
              ),
              SizedBox.square(
                dimension: 48,
                child: PopupMenuButton<String>(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.more_vert, size:24),
                  onSelected: (value) async {
                    switch (value) {
                      case 'toggle_star':
                        await EntryActions.toggleStar(repository, item);
                        setState(() => _refreshToken++);
                        break;
                      case 'duplicate':
                        await EntryActions.duplicateAsToday(repository, entry.id);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Entry duplicated')),
                          );
                        }
                        break;
                      case 'edit':
                        if (!context.mounted) return;
                        await context.push('/coffee/${entry.coffeeId}/entry/${entry.id}/edit');
                        if (mounted) setState(() => _refreshToken++);
                        break;
                      case 'create_template':
                        try {
                          final defaultName = '${entry.brewMethod} ${DateFormat.yMMMd().format(entry.brewAt)}';
                          final name = await _promptTemplateName(context, defaultName);
                          if (name == null || name.trim().isEmpty) break;
                          final tags = item.tags
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
                            steps: EntryActions.stepDraftsFromSteps(item.steps),
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
                      case 'delete':
                        await repository.delete(entry.id);
                        if (context.mounted) {
                          context.pop();
                        }
                        break;
                    }
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
              ),
            ],
          ),
          body: FutureBuilder<CoffeeRecord?>(
            future: coffeeFuture,
            builder: (context, coffeeSnapshot) {
              final bottomInset = MediaQuery.of(context).viewPadding.bottom;
              return ListView(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + bottomInset),
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          DateFormat.yMMMMd().add_Hm().format(entry.brewAt),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ],
                  ),
                  if (coffeeSnapshot.data != null) ... [
                    const SizedBox(height: 12),
                    CoffeeSummaryCard(
                      record: coffeeSnapshot.data!,
                      margin: EdgeInsets.zero,
                      showDetails: false,
                    ),
                  ],
                  //const Divider(height: 32),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      if (entry.extractionOutcome != ExtractionOutcome.unknown.name)
                        Chip(
                          avatar: Icon(DisplayFormatters.extractionOutcomeIcon(entry.extractionOutcome), size: 18),
                          label: Text(
                            DisplayFormatters.formatExtractionOutcome(
                              entry.extractionOutcome,
                            ),
                          ),
                        ),
                      if (entry.isStarred)
                        const Chip(
                          avatar: Icon(Icons.star, color: Colors.amber, size: 18),
                          label: Text('Starred'),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _SectionTitle(title: 'Recipe details'),
                  const SizedBox(height: 8),
                  _InfoGrid(
                    children: [
                        _InfoCard(
                          label: 'Brew method',
                          value: entry.brewMethod,
                          icon: const Icon(Icons.coffee_maker_outlined)
                        ),
                      _InfoCard(
                        label: 'Coffee dose',
                        value: DisplayFormatters.formatWeight(entry.coffeeDoseG),
                        icon: const Icon(Icons.scale_outlined),
                      ),
                      _InfoCard(
                        label: 'Water amount',
                        value: DisplayFormatters.formatWeight(entry.waterTotalG),
                        icon: const Icon(Icons.water_drop_outlined),
                      ),
                      _InfoCard(
                        label: 'Ratio',
                        value: '1:${ratio.toStringAsFixed(1)}',
                        icon: const Icon(Icons.balance_outlined),
                      ),
                      if (temperature != null)
                        _InfoCard(
                          label: 'Water temperature',
                          value: temperature,
                          icon: const Icon(Icons.thermostat_outlined),
                        ),
                      if (grinder != null)
                        _InfoCard(
                          label: 'Grind',
                          value: grinder,
                          icon: const Icon(Icons.tune),
                        ),
                      if (entry.yieldG != null)
                        _InfoCard(
                          label: 'Yield',
                          value: DisplayFormatters.formatWeight(entry.yieldG!),
                          icon: const Icon(Icons.local_drink_outlined),
                        ),
                      if (entry.pressureBar != null)
                        _InfoCard(
                          label: 'Pressure',
                          value: DisplayFormatters.formatPressure(entry.pressureBar!),
                          icon: const Icon(Icons.speed_outlined),
                        ),
                      if (entry.preinfusionSec != null)
                        _InfoCard(
                          label: 'Preinfusion',
                          value: DisplayFormatters.formatDuration(entry.preinfusionSec),
                          icon: const Icon(Icons.timelapse_outlined),
                        ),
                      _InfoCard(
                        label: 'Brew time',
                        value: DisplayFormatters.formatDuration(brewTime),
                        icon: const Icon(Icons.timer_outlined),
                      ),
                    ],
                  ),
                  const Divider(height: 32),
                  _RecipeStepsSection(
                    steps: item.steps,
                    brewTime: brewTime,
                    isBlank: _isBlank,
                  ),
                  const Divider(height: 32),
                  _SectionTitle(title: 'Results'),
                  const SizedBox(height: 8),
                  _InfoGrid(
                    children: [
                      if (entry.drawdownSec != null)
                        _InfoCard(
                          label: 'Drawdown time',
                          value: DisplayFormatters.formatDuration(entry.drawdownSec),
                          icon: const Icon(Icons.hourglass_empty_outlined),
                        ),
                      if (!_isBlank(entry.agitationLevel))
                        _InfoCard(
                          label: 'Agitation level',
                          value: entry.agitationLevel!,
                          icon: const Icon(Icons.tune_outlined),
                        ),
                      if (!_isBlank(entry.dialInNotes))
                        _InfoCard(
                          label: 'Dial-in notes',
                          value: entry.dialInNotes!,
                          icon: const Icon(Icons.description_outlined),
                          fullWidth: true,
                        ),
                      if (!_isBlank(entry.miscNotes))
                        _InfoCard(
                          label: 'Misc notes',
                          value: entry.miscNotes!,
                          icon: const Icon(Icons.description_outlined),
                          fullWidth: true,
                        ),
                    ],
                  ),
                  if (sensory != null) ...[
                    const Divider(height: 32),
                    _SectionTitle(title: 'Sensory'),
                    const SizedBox(height: 8),
                    _InfoGrid(
                      children: [
                        if (!_isBlank(sensory.aroma))
                          _InfoCard(label: 'Aroma', value: sensory.aroma!, fullWidth: true),
                        if (!_isBlank(sensory.flavor))
                          _InfoCard(label: 'Flavor', value: sensory.flavor!, fullWidth: true),
                        if (!_isBlank(sensory.acidity))
                          _InfoCard(label: 'Acidity', value: sensory.acidity!, fullWidth: true),
                        if (!_isBlank(sensory.sweetness))
                          _InfoCard(label: 'Sweetness', value: sensory.sweetness!, fullWidth: true),
                        if (!_isBlank(sensory.body))
                          _InfoCard(label: 'Body', value: sensory.body!, fullWidth: true),
                        if (!_isBlank(sensory.aftertaste))
                          _InfoCard(label: 'Aftertaste', value: sensory.aftertaste!, fullWidth: true),
                        if (!_isBlank(sensory.freeText))
                          _InfoCard(label: 'Notes', value: sensory.freeText!, fullWidth: true),
                      ],
                    ),
                  ],
                ],
              );
            },
          ),
        );
      },
    );
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
            decoration: const InputDecoration(labelText: 'Name'),
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

  bool _isBlank(String? value) => value == null || value.trim().isEmpty;
}

enum _WaterDisplayMode {
  cumulative,
  step,
}

class _RecipeStepsSection extends StatefulWidget {
  const _RecipeStepsSection({
    required this.steps,
    required this.brewTime,
    required this.isBlank,
  });

  final List<EntryStep> steps;
  final int brewTime;
  final bool Function(String?) isBlank;

  @override
  State<_RecipeStepsSection> createState() => _RecipeStepsSectionState();
}

class _RecipeStepsSectionState extends State<_RecipeStepsSection> {
  _WaterDisplayMode _waterDisplayMode = _WaterDisplayMode.cumulative;

  @override
  Widget build(BuildContext context) {
    final normalizedSteps = EntryActions.stepDraftsFromSteps(widget.steps);
    final showEndStep =
        normalizedSteps.isNotEmpty && (normalizedSteps.last.durationSec ?? 0) > 0;
    var cumulativeWater = 0.0;

    return Column(
      children: [
        Row(
          children: [
            const Expanded(child: _SectionTitle(title: 'Recipe steps')),
            SegmentedButton<_WaterDisplayMode>(
              segments: const [
                ButtonSegment<_WaterDisplayMode>(
                  value: _WaterDisplayMode.cumulative,
                  label: Text(
                    'Σ',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
                ButtonSegment<_WaterDisplayMode>(
                  value: _WaterDisplayMode.step,
                  label: Text(
                    'Δ',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ],
              selected: {_waterDisplayMode},
              showSelectedIcon: false,
              onSelectionChanged: (selection) {
                setState(() => _waterDisplayMode = selection.first);
              },
            ),
          ],
        ),
        const SizedBox(height: 8),
        ...normalizedSteps.asMap().entries.map((entryWithIndex) {
          final step = entryWithIndex.value;
          final title = step.type == RecipeStepType.custom &&
                  !widget.isBlank(step.label)
              ? step.label!
              : step.type.name;
          final stepWater = step.waterG;
          if ((stepWater ?? 0) > 0) {
            cumulativeWater += stepWater!;
          }

          final displayedWater = _waterDisplayMode == _WaterDisplayMode.cumulative
              ? cumulativeWater
              : (stepWater ?? 0);
          final hasWater = (stepWater ?? 0) > 0;
          final hasNotes = step.pressureBar != null || !widget.isBlank(step.note);

          return _TimelineStepRow(
            marker: _StepTimelineMarker(
              isFirst: entryWithIndex.key == 0,
              isLast: !showEndStep && entryWithIndex.key == normalizedSteps.length - 1,
              startLabel: DisplayFormatters.formatDuration(step.startSec),
              waterLabel: hasWater
                  ? DisplayFormatters.formatWeight(displayedWater)
                  : '',
            ),
            child: ListTile(
              leading: Text(
                "${step.index + 1}",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (hasWater) ...[
                    const Icon(Icons.water_drop_outlined, size: 18),
                    const SizedBox(width: 6),
                    Text(
                      DisplayFormatters.formatWeight(displayedWater),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ]
                ],
              ),
              title: Text(title),
              subtitle: hasNotes
                  ? Text(
                      [
                        if (step.pressureBar != null)
                          DisplayFormatters.formatPressure(step.pressureBar!),
                        if (!widget.isBlank(step.note)) step.note,
                      ].join(' • '),
                    )
                  : null,
            ),
          );
        }),
        if (showEndStep)
          _TimelineStepRow(
            marker: _StepTimelineMarker(
              isFirst: false,
              isLast: true,
              startLabel: DisplayFormatters.formatDuration(widget.brewTime),
              waterLabel: '',
            ),
            child: const ListTile(
              title: Text('End'),
            ),
          ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
    );
  }
}

class _InfoGrid extends StatelessWidget {
  const _InfoGrid({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) {
      return const SizedBox.shrink();
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        const spacing = 8.0;
        final halfWidth = (constraints.maxWidth - spacing) / 2;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: children.map((child) {
            final fullWidth = child is _InfoCard && child.fullWidth;
            return SizedBox(
              width: fullWidth ? constraints.maxWidth : halfWidth,
              child: child,
            );
          }).toList(growable: false),
        );
      },
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.label,
    required this.value,
    this.icon,
    this.fullWidth = false,
  });

  final String label;
  final String value;
  final Icon? icon;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Row(
          children: [
            if (icon != null) ...[
              IconTheme(
                data: IconThemeData(
                  size: 18,
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: icon!,
              ),
              const SizedBox(width: 10),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: fullWidth
                        ? Theme.of(context).textTheme.bodyMedium
                        : Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                    softWrap: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TimelineStepRow extends StatelessWidget {
  const _TimelineStepRow({
    required this.marker,
    required this.child,
  });

  final Widget marker;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            marker,
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Card(
                  margin: EdgeInsets.zero,
                  child: child,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StepTimelineMarker extends StatelessWidget {
  const _StepTimelineMarker({
    required this.isFirst,
    required this.isLast,
    required this.startLabel,
    required this.waterLabel,
  });

  final bool isFirst;
  final bool isLast;
  final String startLabel;
  final String waterLabel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48, // 140
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 44,
            child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // if (startLabel != '') Icon(Icons.timer_outlined, size: 18),
                  Text(
                    startLabel,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ),
          // SizedBox(
          //   width: 16,
          //   child: Center(
          //     child: Column(
          //       children: [
          //         Expanded(
          //           child: Container(
          //             width: 2,
          //             color: isFirst ? Colors.transparent : lineColor,
          //           ),
          //         ),
          //         Container(
          //           width: 12,
          //           height: 2,
          //           color: dotColor,
          //         ),
          //         Expanded(
          //           child: Container(
          //             width: 2,
          //             color: isLast ? Colors.transparent : lineColor,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
