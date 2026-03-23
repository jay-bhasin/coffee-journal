import 'dart:convert';

import 'package:coffee_journal/core/db/database.dart';
import 'package:coffee_journal/core/db/database_provider.dart';
import 'package:coffee_journal/core/models/enums.dart';
import 'package:coffee_journal/core/models/recipe_step_draft.dart';
import 'package:coffee_journal/core/models/sensory_notes.dart';
import 'package:coffee_journal/core/repositories/contracts.dart';
import 'package:coffee_journal/core/utils/unit_converter.dart';
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
        final sensory = entry.sensoryJson == null
            ? null
            : SensoryNotes.fromJson(jsonDecode(entry.sensoryJson!) as Map<String, dynamic>);

        return Scaffold(
          appBar: AppBar(
            title: Text(DateFormat.yMMMMd().add_Hm().format(entry.brewAt)),
            actions: [
              if (entry.isStarred)
                const Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Icon(Icons.star, color: Colors.amber),
                ),
              PopupMenuButton<String>(
                onSelected: (value) async {
                  switch (value) {
                    case 'toggle_star':
                      await repository.upsert(
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
                        steps: _stepsToDrafts(item.steps),
                        tags: item.tags,
                      );
                      setState(() => _refreshToken++);
                      break;
                    case 'duplicate':
                      await repository.duplicateEntryToNewDay(entry.id, DateTime.now());
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Duplicated as today')),
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
                          steps: _stepsToDrafts(item.steps),
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
                  const PopupMenuItem(value: 'duplicate', child: Text('Duplicate as today')),
                  const PopupMenuItem(value: 'edit', child: Text('Edit')),
                  const PopupMenuItem(
                    value: 'create_template',
                    child: Text('Create template from entry'),
                  ),
                  const PopupMenuItem(value: 'delete', child: Text('Delete')),
                ],
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Text(
              //   DateFormat.yMMMMd().add_Hm().format(entry.brewAt),
              //   style: Theme.of(context).textTheme.titleLarge,
              // ),
              Text('Recipe details', style: Theme.of(context).textTheme.titleMedium),

              const SizedBox(height: 8),
              Text('Method: ${entry.brewMethod}'),
              Text('Dose: ${_formatWeight(entry.coffeeDoseG)}'),
              Text('Water: ${_formatWeight(entry.waterTotalG)}'),
              if (_formatTemperature(entry.waterTempC, unitSystem, unitConverter) != null)
                Text('Temperature: ${_formatTemperature(entry.waterTempC, unitSystem, unitConverter)!}'),
              if (_formatGrinder(entry.grinder, entry.grindSetting) != null)
                Text('Grinder: ${_formatGrinder(entry.grinder, entry.grindSetting)!}'),
              Text('Brew time: ${_formatDuration(entry.brewTimeSecManual ?? entry.brewTimeSecAuto)}'),
              if (entry.extractionOutcome != ExtractionOutcome.unknown.name)
                Text('Extraction outcome: ${entry.extractionOutcome}'),
              if (entry.drawdownSec != null) Text('Drawdown: ${_formatDuration(entry.drawdownSec!)}'),
              if (!_isBlank(entry.agitationLevel)) Text('Agitation: ${entry.agitationLevel}'),
              if (!_isBlank(entry.dialInNotes)) Text('Dial-in notes: ${entry.dialInNotes}'),
              if (!_isBlank(entry.miscNotes)) Text('Misc notes: ${entry.miscNotes}'),
              if (item.tags.isNotEmpty) Text('Tags: ${item.tags.join(', ')}'),
              const Divider(height: 24),
              Text('Steps', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              ...item.steps.asMap().entries.map(
                (entryWithIndex) => Card(
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: _StepTimelineMarker(
                            isFirst: entryWithIndex.key == 0,
                            isLast: entryWithIndex.key == item.steps.length - 1,
                            startLabel: _formatDuration(entryWithIndex.value.startSec),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text('${entryWithIndex.value.stepIndex + 1}. ${entryWithIndex.value.type}'),
                            subtitle: Text(
                              [
                                if (entryWithIndex.value.waterG != null)
                                  _formatWeight(entryWithIndex.value.waterG!),
                                if (entryWithIndex.value.pressureBar != null)
                                  '${entryWithIndex.value.pressureBar!.toStringAsFixed(1)} bar',
                                if (!_isBlank(entryWithIndex.value.note)) entryWithIndex.value.note,
                                if (!_isBlank(entryWithIndex.value.label)) entryWithIndex.value.label,
                              ].join(' • '),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: _StepTimelineMarker(
                          isFirst: false,
                          isLast: true,
                          startLabel: _formatDuration(entry.brewTimeSecManual ?? entry.brewTimeSecAuto),
                        ),
                      ),
                      const Expanded(
                        child: ListTile(
                          title: Text('End'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (sensory != null) ...[
                const Divider(height: 24),
                Text('Sensory', style: Theme.of(context).textTheme.titleMedium),
                if (!_isBlank(sensory.aroma)) Text('Aroma: ${sensory.aroma}'),
                if (!_isBlank(sensory.flavor)) Text('Flavor: ${sensory.flavor}'),
                if (!_isBlank(sensory.acidity)) Text('Acidity: ${sensory.acidity}'),
                if (!_isBlank(sensory.sweetness)) Text('Sweetness: ${sensory.sweetness}'),
                if (!_isBlank(sensory.body)) Text('Body: ${sensory.body}'),
                if (!_isBlank(sensory.aftertaste)) Text('Aftertaste: ${sensory.aftertaste}'),
                if (!_isBlank(sensory.freeText)) Text('Notes: ${sensory.freeText}'),
              ],
            ],
          ),
        );
      },
    );
  }

  List<RecipeStepDraft> _stepsToDrafts(List<EntryStep> steps) {
    return steps
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

  String _formatDuration(int? seconds) {
    if (seconds == null) return '-';
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
}

class _StepTimelineMarker extends StatelessWidget {
  const _StepTimelineMarker({
    required this.isFirst,
    required this.isLast,
    required this.startLabel,
  });

  final bool isFirst;
  final bool isLast;
  final String startLabel;

  @override
  Widget build(BuildContext context) {
    final lineColor = Theme.of(context).colorScheme.outlineVariant;
    final dotColor = Theme.of(context).colorScheme.primary;

    return SizedBox(
      width: 68,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 16,
            child: Center(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      width: 2,
                      color: isFirst ? Colors.transparent : lineColor,
                    ),
                  ),
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: dotColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: 2,
                      color: isLast ? Colors.transparent : lineColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 44,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                startLabel,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.right,
              ),
            ),
          ),
        ],
      ),
    );
  }
}