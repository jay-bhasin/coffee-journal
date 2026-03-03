import 'dart:convert';

import 'package:coffee_journal/core/db/database_provider.dart';
import 'package:coffee_journal/core/models/enums.dart';
import 'package:coffee_journal/core/models/recipe_step_draft.dart';
import 'package:coffee_journal/core/models/sensory_notes.dart';
import 'package:coffee_journal/core/repositories/contracts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EntryFormScreen extends ConsumerStatefulWidget {
  const EntryFormScreen({
    super.key,
    required this.coffeeId,
    this.entryId,
    this.duplicateFromEntryId,
  });

  final String coffeeId;
  final String? entryId;
  final String? duplicateFromEntryId;

  @override
  ConsumerState<EntryFormScreen> createState() => _EntryFormScreenState();
}

class _EntryFormScreenState extends ConsumerState<EntryFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final _coffeeDoseController = TextEditingController(text: '20');
  final _waterController = TextEditingController(text: '300');
  final _tempController = TextEditingController(text: '94');
  final _grinderController = TextEditingController();
  final _grindSettingController = TextEditingController();
  final _yieldController = TextEditingController();
  final _pressureController = TextEditingController();
  final _preinfusionController = TextEditingController();
  final _drawdownController = TextEditingController();
  final _agitationController = TextEditingController();
  final _dialInController = TextEditingController();
  final _miscController = TextEditingController();
  final _tagsController = TextEditingController();

  final _aromaController = TextEditingController();
  final _flavorController = TextEditingController();
  final _acidityController = TextEditingController();
  final _sweetnessController = TextEditingController();
  final _bodyController = TextEditingController();
  final _aftertasteController = TextEditingController();
  final _sensoryFreeTextController = TextEditingController();

  String _method = 'V60';
  ExtractionOutcome _extractionOutcome = ExtractionOutcome.unknown;
  DateTime _brewAt = DateTime.now();
  bool _isStarred = false;
  bool _ratioLocked = false;
  int? _brewTimeManual;

  List<RecipeStepDraft> _steps = [];
  bool _loaded = false;
  late Future<EntryRecord?> _loadFuture;

  @override
  void initState() {
    super.initState();
    _loadFuture = _buildLoadFuture();
  }

  @override
  void didUpdateWidget(covariant EntryFormScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.entryId != widget.entryId ||
        oldWidget.duplicateFromEntryId != widget.duplicateFromEntryId) {
      _loaded = false;
      _loadFuture = _buildLoadFuture();
    }
  }

  @override
  void dispose() {
    _coffeeDoseController.dispose();
    _waterController.dispose();
    _tempController.dispose();
    _grinderController.dispose();
    _grindSettingController.dispose();
    _yieldController.dispose();
    _pressureController.dispose();
    _preinfusionController.dispose();
    _drawdownController.dispose();
    _agitationController.dispose();
    _dialInController.dispose();
    _miscController.dispose();
    _tagsController.dispose();

    _aromaController.dispose();
    _flavorController.dispose();
    _acidityController.dispose();
    _sweetnessController.dispose();
    _bodyController.dispose();
    _aftertasteController.dispose();
    _sensoryFreeTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final repository = ref.watch(entryRepositoryProvider);
    final scaler = ref.watch(recipeScalerProvider);
    final brewTimeCalculator = ref.watch(brewTimeCalculatorProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.entryId == null ? 'New entry' : 'Edit entry'),
        actions: [
          IconButton(
            tooltip: 'Save entry',
            onPressed: () async {
              final autoBrewTime =
                  ref.read(brewTimeCalculatorProvider).calculateAutoBrewTimeSec(_steps);
              await _saveEntry(repository, autoBrewTime);
            },
            icon: const Icon(Icons.save_outlined),
          ),
        ],
      ),
      body: FutureBuilder<EntryRecord?>(
        future: _loadFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              (widget.entryId != null || widget.duplicateFromEntryId != null)) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!_loaded && snapshot.data != null) {
            final EntryRecord item = snapshot.data!;
            final entry = item.entry;
            _brewAt = widget.entryId == null ? DateTime.now() : entry.brewAt;
            _method = entry.brewMethod;
            _isStarred = entry.isStarred;
            _extractionOutcome = ExtractionOutcome.values.firstWhere(
              (e) => e.name == entry.extractionOutcome,
              orElse: () => ExtractionOutcome.unknown,
            );
            _coffeeDoseController.text = entry.coffeeDoseG.toString();
            _waterController.text = entry.waterTotalG.toString();
            _tempController.text = entry.waterTempC?.toString() ?? '';
            _grinderController.text = entry.grinder ?? '';
            _grindSettingController.text = entry.grindSetting ?? '';
            _yieldController.text = entry.yieldG?.toString() ?? '';
            _pressureController.text = entry.pressureBar?.toString() ?? '';
            _preinfusionController.text = entry.preinfusionSec?.toString() ?? '';
            _drawdownController.text = entry.drawdownSec?.toString() ?? '';
            _agitationController.text = entry.agitationLevel ?? '';
            _dialInController.text = entry.dialInNotes ?? '';
            _miscController.text = entry.miscNotes ?? '';
            _tagsController.text = item.tags.join(', ');
            _brewTimeManual = entry.brewTimeSecManual;
            _steps = item.steps
                .map<RecipeStepDraft>(
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

            if (entry.sensoryJson != null && entry.sensoryJson!.isNotEmpty) {
              final sensory =
                  SensoryNotes.fromJson(jsonDecode(entry.sensoryJson!) as Map<String, dynamic>);
              _aromaController.text = sensory.aroma ?? '';
              _flavorController.text = sensory.flavor ?? '';
              _acidityController.text = sensory.acidity ?? '';
              _sweetnessController.text = sensory.sweetness ?? '';
              _bodyController.text = sensory.body ?? '';
              _aftertasteController.text = sensory.aftertaste ?? '';
              _sensoryFreeTextController.text = sensory.freeText ?? '';
            }
            _loaded = true;
          }

          final autoBrewTime = brewTimeCalculator.calculateAutoBrewTimeSec(_steps);

          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text('Brewed at: ${_brewAt.toLocal().toString().split('.').first}'),
                    ),
                    TextButton(
                      onPressed: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: _brewAt,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (date != null && context.mounted) {
                          setState(() {
                            _brewAt = DateTime(
                              date.year,
                              date.month,
                              date.day,
                              _brewAt.hour,
                              _brewAt.minute,
                            );
                          });
                        }
                      },
                      child: const Text('Change date'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                FutureBuilder<List<BrewMethodOption>>(
                  future: ref.watch(brewMethodRepositoryProvider).list(),
                  builder: (context, methodSnapshot) {
                    final methods = methodSnapshot.data ?? const <BrewMethodOption>[];
                    if (methods.isNotEmpty && !methods.any((m) => m.name == _method)) {
                      _method = methods.first.name;
                    }
                    return DropdownButtonFormField<String>(
                      initialValue:
                          methods.any((m) => m.name == _method) ? _method : (methods.isEmpty ? null : methods.first.name),
                      decoration: const InputDecoration(labelText: 'Method'),
                      items: methods
                          .map((m) => DropdownMenuItem<String>(value: m.name, child: Text(m.name)))
                          .toList(),
                      onChanged: (value) => setState(() => _method = value ?? _method),
                    );
                  },
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Star entry'),
                  value: _isStarred,
                  onChanged: (v) => setState(() => _isStarred = v),
                ),
                TextFormField(
                  controller: _coffeeDoseController,
                  decoration: const InputDecoration(labelText: 'Coffee dose (g) *'),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  validator: (v) => (double.tryParse(v ?? '') ?? 0) <= 0 ? 'Must be > 0' : null,
                  onChanged: (value) {
                    if (!_ratioLocked) return;
                    final newDose = double.tryParse(value);
                    if (newDose == null || newDose <= 0) return;
                    final currentRatio = scaler.computeRatio(
                      coffeeDoseG: double.tryParse(_coffeeDoseController.text) ?? 0,
                      waterTotalG: double.tryParse(_waterController.text) ?? 0,
                    );
                    final targetWater = scaler.counterpartForLockedRatio(
                      changedValue: newDose,
                      changedCoffeeDose: true,
                      ratio: currentRatio,
                    );
                    final oldWater = double.tryParse(_waterController.text) ?? 0;
                    setState(() {
                      _waterController.text = targetWater.toStringAsFixed(1);
                      _steps = scaler.redistributeWater(_steps, oldWater, targetWater);
                    });
                  },
                ),
                TextFormField(
                  controller: _waterController,
                  decoration: const InputDecoration(labelText: 'Water total (g) *'),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  validator: (v) => (double.tryParse(v ?? '') ?? 0) <= 0 ? 'Must be > 0' : null,
                  onChanged: (value) {
                    final newWater = double.tryParse(value);
                    if (newWater == null || newWater <= 0) return;
                    final oldWater = double.tryParse(_waterController.text) ?? 0;
                    if (_ratioLocked) {
                      final currentRatio = scaler.computeRatio(
                        coffeeDoseG: double.tryParse(_coffeeDoseController.text) ?? 0,
                        waterTotalG: oldWater,
                      );
                      final targetCoffee = scaler.counterpartForLockedRatio(
                        changedValue: newWater,
                        changedCoffeeDose: false,
                        ratio: currentRatio,
                      );
                      _coffeeDoseController.text = targetCoffee.toStringAsFixed(1);
                    }
                    setState(() {
                      _steps = scaler.redistributeWater(_steps, oldWater, newWater);
                    });
                  },
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Lock ratio'),
                  subtitle: const Text('Changing coffee or water auto-updates the other field.'),
                  value: _ratioLocked,
                  onChanged: (v) => setState(() => _ratioLocked = v),
                ),
                ValueListenableBuilder<TextEditingValue>(
                  valueListenable: _coffeeDoseController,
                  builder: (context, coffeeValue, _) {
                    return ValueListenableBuilder<TextEditingValue>(
                      valueListenable: _waterController,
                      builder: (context, waterValue, _) {
                        final coffeeDose = double.tryParse(coffeeValue.text) ?? 0;
                        final water = double.tryParse(waterValue.text) ?? 0;
                        final ratio = scaler.computeRatio(
                          coffeeDoseG: coffeeDose,
                          waterTotalG: water,
                        );
                        return Text('Ratio: 1:${ratio.toStringAsFixed(1)}');
                      },
                    );
                  },
                ),
                TextFormField(
                  controller: _tempController,
                  decoration: const InputDecoration(labelText: 'Water temperature (C)'),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                ),
                TextFormField(
                  controller: _grinderController,
                  decoration: const InputDecoration(labelText: 'Grinder'),
                ),
                TextFormField(
                  controller: _grindSettingController,
                  decoration: const InputDecoration(labelText: 'Grind setting'),
                ),
                TextFormField(
                  controller: _yieldController,
                  decoration: const InputDecoration(labelText: 'Yield (g, optional)'),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                ),
                TextFormField(
                  controller: _pressureController,
                  decoration: const InputDecoration(labelText: 'Pressure (bar, optional)'),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                ),
                TextFormField(
                  controller: _preinfusionController,
                  decoration: const InputDecoration(labelText: 'Preinfusion (sec, optional)'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Recipe steps (${_steps.length}) • Auto brew time: ${autoBrewTime}s',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () async {
                        final step = await _showStepDialog(
                          context,
                          index: _steps.length,
                        );
                        if (step != null) {
                          setState(() {
                            _steps = [..._steps, step.copyWith(index: _steps.length)];
                          });
                        }
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Step'),
                    ),
                  ],
                ),
                if (_steps.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text('No recipe steps yet.'),
                  )
                else
                  ReorderableListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _steps.length,
                    onReorder: (oldIndex, newIndex) {
                      setState(() {
                        if (newIndex > oldIndex) newIndex -= 1;
                        final step = _steps.removeAt(oldIndex);
                        _steps.insert(newIndex, step);
                        _steps = _steps
                            .asMap()
                            .entries
                            .map((e) => e.value.copyWith(index: e.key))
                            .toList(growable: false);
                      });
                    },
                    itemBuilder: (context, index) {
                      final step = _steps[index];
                      return Card(
                        key: ValueKey('step-${step.index}-${step.type.name}-$index'),
                        child: IntrinsicHeight(
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: _StepTimelineMarker(
                                  isFirst: index == 0,
                                  isLast: index == _steps.length - 1,
                                  startSec: step.startSec,
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Text('${index + 1}. ${step.type.name}'),
                                  subtitle: Text(
                                    [
                                      if (step.waterG != null) '${step.waterG!.toStringAsFixed(1)}g water',
                                      if (step.startSec != null) 'start ${step.startSec}s',
                                      if (step.durationSec != null) 'dur ${step.durationSec}s',
                                      if (step.pressureBar != null) '${step.pressureBar!.toStringAsFixed(1)}bar',
                                      if (step.note != null) step.note,
                                    ].join(' • '),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit_outlined),
                                        onPressed: () async {
                                          final edited = await _showStepDialog(
                                            context,
                                            initialStep: step,
                                            index: index,
                                          );
                                          if (edited == null) return;
                                          setState(() {
                                            _steps[index] = edited.copyWith(index: index);
                                          });
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete_outline),
                                        onPressed: () {
                                          setState(() {
                                            _steps.removeAt(index);
                                            _steps = _steps
                                                .asMap()
                                                .entries
                                                .map((e) => e.value.copyWith(index: e.key))
                                                .toList(growable: false);
                                          });
                                        },
                                      ),
                                      ReorderableDragStartListener(
                                        index: index,
                                        child: const Icon(Icons.drag_handle),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                const SizedBox(height: 16),
                DropdownButtonFormField<ExtractionOutcome>(
                  initialValue: _extractionOutcome,
                  decoration: const InputDecoration(labelText: 'Extraction outcome'),
                  items: ExtractionOutcome.values
                      .map((e) => DropdownMenuItem(value: e, child: Text(e.name)))
                      .toList(),
                  onChanged: (v) => setState(() => _extractionOutcome = v ?? _extractionOutcome),
                ),
                TextFormField(
                  controller: _drawdownController,
                  decoration: const InputDecoration(labelText: 'Drawdown (sec)'),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  controller: _agitationController,
                  decoration: const InputDecoration(labelText: 'Agitation level'),
                ),
                TextFormField(
                  controller: _dialInController,
                  minLines: 2,
                  maxLines: 3,
                  decoration: const InputDecoration(labelText: 'Dial-in notes'),
                ),
                TextFormField(
                  controller: _miscController,
                  minLines: 2,
                  maxLines: 3,
                  decoration: const InputDecoration(labelText: 'Misc notes'),
                ),
                TextFormField(
                  controller: _tagsController,
                  decoration: const InputDecoration(labelText: 'Tags (comma-separated)'),
                ),
                const Divider(height: 28),
                Text('Sensory notes', style: Theme.of(context).textTheme.titleMedium),
                TextFormField(
                  controller: _aromaController,
                  decoration: const InputDecoration(labelText: 'Aroma'),
                ),
                TextFormField(
                  controller: _flavorController,
                  decoration: const InputDecoration(labelText: 'Flavor'),
                ),
                TextFormField(
                  controller: _acidityController,
                  decoration: const InputDecoration(labelText: 'Acidity'),
                ),
                TextFormField(
                  controller: _sweetnessController,
                  decoration: const InputDecoration(labelText: 'Sweetness'),
                ),
                TextFormField(
                  controller: _bodyController,
                  decoration: const InputDecoration(labelText: 'Body'),
                ),
                TextFormField(
                  controller: _aftertasteController,
                  decoration: const InputDecoration(labelText: 'Aftertaste'),
                ),
                TextFormField(
                  controller: _sensoryFreeTextController,
                  minLines: 2,
                  maxLines: 3,
                  decoration: const InputDecoration(labelText: 'Sensory free notes'),
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: () => _saveEntry(repository, autoBrewTime),
                  child: const Text('Save entry'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<RecipeStepDraft?> _showStepDialog(
    BuildContext context, {
    RecipeStepDraft? initialStep,
    required int index,
  }) async {
    RecipeStepType type = initialStep?.type ?? RecipeStepType.pour;
    final waterController = TextEditingController(text: initialStep?.waterG?.toString() ?? '');
    final startController = TextEditingController(text: initialStep?.startSec?.toString() ?? '');
    final durationController =
        TextEditingController(text: initialStep?.durationSec?.toString() ?? '');
    final noteController = TextEditingController(text: initialStep?.note ?? '');
    final pressureController =
        TextEditingController(text: initialStep?.pressureBar?.toString() ?? '');
    final isEditing = initialStep != null;

    return showDialog<RecipeStepDraft>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: Text(isEditing ? 'Edit step' : 'Add step'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButtonFormField<RecipeStepType>(
                      initialValue: type,
                      items: RecipeStepType.values
                          .map((e) => DropdownMenuItem(value: e, child: Text(e.name)))
                          .toList(),
                      onChanged: (v) => setStateDialog(() => type = v ?? type),
                    ),
                    TextField(
                      controller: waterController,
                      decoration: const InputDecoration(labelText: 'Water (g) optional'),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    ),
                    TextField(
                      controller: startController,
                      decoration: const InputDecoration(labelText: 'Start (sec)'),
                      keyboardType: TextInputType.number,
                    ),
                    TextField(
                      controller: durationController,
                      decoration: const InputDecoration(labelText: 'Duration (sec)'),
                      keyboardType: TextInputType.number,
                    ),
                    TextField(
                      controller: pressureController,
                      decoration: const InputDecoration(labelText: 'Pressure (bar) optional'),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    ),
                    TextField(
                      controller: noteController,
                      decoration: const InputDecoration(labelText: 'Note'),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
                FilledButton(
                  onPressed: () {
                    Navigator.of(context).pop(
                      RecipeStepDraft(
                        type: type,
                        index: index,
                        waterG: double.tryParse(waterController.text),
                        startSec: int.tryParse(startController.text),
                        durationSec: int.tryParse(durationController.text),
                        pressureBar: double.tryParse(pressureController.text),
                        note: _clean(noteController.text),
                      ),
                    );
                  },
                  child: Text(isEditing ? 'Save' : 'Add'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  List<String> _splitTags(String raw) {
    return raw
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toSet()
        .toList();
  }

  String? _clean(String raw) {
    final trimmed = raw.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  Future<EntryRecord?> _buildLoadFuture() {
    final repository = ref.read(entryRepositoryProvider);
    if (widget.entryId != null) {
      return repository.getById(widget.entryId!);
    }
    if (widget.duplicateFromEntryId != null) {
      return repository.getById(widget.duplicateFromEntryId!);
    }
    return Future.value(null);
  }

  Future<void> _saveEntry(EntryRepository repository, int autoBrewTime) async {
    if (!_formKey.currentState!.validate()) return;
    final sensory = SensoryNotes(
      aroma: _clean(_aromaController.text),
      flavor: _clean(_flavorController.text),
      acidity: _clean(_acidityController.text),
      sweetness: _clean(_sweetnessController.text),
      body: _clean(_bodyController.text),
      aftertaste: _clean(_aftertasteController.text),
      freeText: _clean(_sensoryFreeTextController.text),
    );

    await repository.upsert(
      id: widget.entryId,
      coffeeId: widget.coffeeId,
      brewAt: _brewAt,
      brewMethod: _method,
      isStarred: _isStarred,
      coffeeDoseG: double.parse(_coffeeDoseController.text),
      waterTotalG: double.parse(_waterController.text),
      waterTempC: double.tryParse(_tempController.text),
      grinder: _clean(_grinderController.text),
      grindSetting: _clean(_grindSettingController.text),
      yieldG: double.tryParse(_yieldController.text),
      pressureBar: double.tryParse(_pressureController.text),
      preinfusionSec: int.tryParse(_preinfusionController.text),
      brewTimeSecAuto: autoBrewTime,
      brewTimeSecManual: _brewTimeManual,
      sensoryJson: jsonEncode(sensory.toJson()),
      dialInNotes: _clean(_dialInController.text),
      miscNotes: _clean(_miscController.text),
      agitationLevel: _clean(_agitationController.text),
      drawdownSec: int.tryParse(_drawdownController.text),
      extractionOutcome: _extractionOutcome,
      steps: _steps,
      tags: _splitTags(_tagsController.text),
    );
    if (mounted) context.pop();
  }
}

class _StepTimelineMarker extends StatelessWidget {
  const _StepTimelineMarker({
    required this.isFirst,
    required this.isLast,
    required this.startSec,
  });

  final bool isFirst;
  final bool isLast;
  final int? startSec;

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
                startSec == null ? '-' : '${startSec}s',
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
