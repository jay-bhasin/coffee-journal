import 'dart:convert';

import 'package:coffee_journal/core/db/database_provider.dart';
import 'package:coffee_journal/core/models/enums.dart';
import 'package:coffee_journal/core/models/recipe_step_draft.dart';
import 'package:coffee_journal/core/models/sensory_notes.dart';
import 'package:coffee_journal/core/repositories/contracts.dart';
import 'package:coffee_journal/core/utils/display_formatters.dart';
import 'package:coffee_journal/core/utils/recipe_scaler.dart';
import 'package:coffee_journal/core/utils/recipe_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EntryFormScreen extends ConsumerStatefulWidget {
  const EntryFormScreen({
    super.key,
    required this.coffeeId,
    this.entryId,
    this.duplicateFromEntryId,
    this.templateId,
  });

  final String coffeeId;
  final String? entryId;
  final String? duplicateFromEntryId;
  final String? templateId;

  @override
  ConsumerState<EntryFormScreen> createState() => _EntryFormScreenState();
}

class _EntryFormScreenState extends ConsumerState<EntryFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final _coffeeDoseController = TextEditingController(text: '20');
  final _waterController = TextEditingController(text: '300');
  final _ratioController = TextEditingController(text: '15.0');
  final _tempController = TextEditingController(text: '94');
  final _waterConditionController = TextEditingController();
  final _grinderController = TextEditingController();
  final _grindSettingController = TextEditingController();
  final _yieldController = TextEditingController();
  final _pressureController = TextEditingController();
  final _preinfusionController = TextEditingController();
  final _drawdownController = TextEditingController();
  final _agitationController = TextEditingController();
  final _dialInController = TextEditingController();
  final _miscController = TextEditingController();

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
  _LockedRecipeField _lockedField = _LockedRecipeField.ratio;
  int? _brewTimeManual;
  bool _isApplyingTriLockUpdate = false;

  List<RecipeStepDraft> _steps = [];
  bool _loaded = false;
  late Future<_EntryFormSeed> _loadFuture;

  @override
  void initState() {
    super.initState();
    _loadFuture = _buildLoadFuture();
    _syncRatioController(const RecipeScaler());
  }

  @override
  void didUpdateWidget(covariant EntryFormScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.entryId != widget.entryId ||
        oldWidget.duplicateFromEntryId != widget.duplicateFromEntryId ||
        oldWidget.templateId != widget.templateId) {
      _loaded = false;
      _loadFuture = _buildLoadFuture();
    }
  }

  @override
  void dispose() {
    _coffeeDoseController.dispose();
    _waterController.dispose();
    _ratioController.dispose();
    _tempController.dispose();
    _waterConditionController.dispose();
    _grinderController.dispose();
    _grindSettingController.dispose();
    _yieldController.dispose();
    _pressureController.dispose();
    _preinfusionController.dispose();
    _drawdownController.dispose();
    _agitationController.dispose();
    _dialInController.dispose();
    _miscController.dispose();

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

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.entryId == null ? 'New entry' : 'Edit entry'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Center(
                child: FilledButton(
                  onPressed: () async {
                    final autoBrewTime =
                        ref.read(brewTimeCalculatorProvider).calculateAutoBrewTimeSec(_steps);
                    await _saveEntry(repository, autoBrewTime);
                  },
                  style: FilledButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                  ),
                  child: const Text('Save'),
                ),
              ),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Recipe'),
              Tab(text: 'Results'),
            ],
          ),
        ),
        body: FutureBuilder<_EntryFormSeed>(
          future: _loadFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting &&
                (widget.entryId != null ||
                    widget.duplicateFromEntryId != null ||
                    widget.templateId != null)) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!_loaded && snapshot.data != null && snapshot.data!.entry != null) {
              final EntryRecord item = snapshot.data!.entry!;
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
              _waterConditionController.text = entry.waterCondition ?? '';
              _grinderController.text = entry.grinder ?? '';
              _grindSettingController.text = entry.grindSetting ?? '';
              _yieldController.text = entry.yieldG?.toString() ?? '';
              _pressureController.text = entry.pressureBar?.toString() ?? '';
              _preinfusionController.text = entry.preinfusionSec?.toString() ?? '';
              _drawdownController.text = entry.drawdownSec?.toString() ?? '';
              _agitationController.text = entry.agitationLevel ?? '';
              _dialInController.text = entry.dialInNotes ?? '';
              _miscController.text = entry.miscNotes ?? '';
              _brewTimeManual = entry.brewTimeSecManual;
              _lockedField = _LockedRecipeField.ratio;
              _steps = RecipeTimeline.normalize(
                item.steps.map<RecipeStepDraft>(
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
                ),
              );

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
              _syncRatioController(scaler);
              _loaded = true;
            }
            if (!_loaded && snapshot.data != null && snapshot.data!.template != null) {
              final TemplateRecord item = snapshot.data!.template!;
              final template = item.template;
              _brewAt = DateTime.now();
              _method = template.brewMethod;
              _isStarred = false;
              _extractionOutcome = ExtractionOutcome.unknown;
              _coffeeDoseController.text = template.defaultCoffeeDoseG?.toString() ?? '20';
              _waterController.text = template.defaultWaterTotalG?.toString() ?? '300';
              _tempController.text = '';
              _waterConditionController.text = '';
              _grinderController.text = '';
              _grindSettingController.text = '';
              _yieldController.text = '';
              _pressureController.text = '';
              _preinfusionController.text = '';
              _drawdownController.text = '';
              _agitationController.text = '';
              _dialInController.text = '';
              _miscController.text = '';
              _brewTimeManual = null;
              _lockedField = _LockedRecipeField.ratio;
              _steps = RecipeTimeline.normalize(
                item.steps.map<RecipeStepDraft>(
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
                ),
              );
              _aromaController.text = '';
              _flavorController.text = '';
              _acidityController.text = '';
              _sweetnessController.text = '';
              _bodyController.text = '';
              _aftertasteController.text = '';
              _sensoryFreeTextController.text = '';
              _syncRatioController(scaler);
              _loaded = true;
            }

            final autoBrewTime = brewTimeCalculator.calculateAutoBrewTimeSec(_steps);
            final bottomInset = MediaQuery.of(context).viewPadding.bottom;

            return Form(
              key: _formKey,
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _KeepAliveTab(
                    child: ListView(
                      key: const PageStorageKey('entry-form-recipe-tab'),
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + bottomInset),
                      children: _buildRecipeTab(
                        context,
                        scaler: scaler,
                        autoBrewTime: autoBrewTime,
                      ),
                    ),
                  ),
                  _KeepAliveTab(
                    child: ListView(
                      key: const PageStorageKey('entry-form-results-tab'),
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + bottomInset),
                      children: _buildResultsTab(context),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  List<Widget> _buildRecipeTab(
    BuildContext context, {
    required RecipeScaler scaler,
    required int autoBrewTime,
  }) {
    return [
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
                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.fromDateTime(_brewAt),
                );
                if (time != null && context.mounted) {
                  setState(() {
                    _brewAt = DateTime(
                      date.year,
                      date.month,
                      date.day,
                      time.hour,
                      time.minute,
                    );
                  });
                }
              }
            },
            child: const Text('Change date/time'),
          ),
        ],
      ),
      const SizedBox(height: 12),
      
      TextFormField(
        controller: _coffeeDoseController,
        readOnly: _lockedField == _LockedRecipeField.dose,
        decoration: InputDecoration(
          labelText: 'Coffee dose (g) *',
          suffixIcon: _LockButton(
            isLocked: _lockedField == _LockedRecipeField.dose,
            onPressed: () => setState(() => _lockedField = _LockedRecipeField.dose),
          ),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        validator: (v) => (double.tryParse(v ?? '') ?? 0) <= 0 ? 'Must be > 0' : null,
        onChanged: (_) => _handleTriLockEdit(
          editedField: _LockedRecipeField.dose,
          scaler: scaler,
        ),
      ),
      TextFormField(
        controller: _waterController,
        readOnly: _lockedField == _LockedRecipeField.water,
        decoration: InputDecoration(
          labelText: 'Water total (g) *',
          suffixIcon: _LockButton(
            isLocked: _lockedField == _LockedRecipeField.water,
            onPressed: () => setState(() => _lockedField = _LockedRecipeField.water),
          ),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        validator: (v) => (double.tryParse(v ?? '') ?? 0) <= 0 ? 'Must be > 0' : null,
        onChanged: (_) => _handleTriLockEdit(
          editedField: _LockedRecipeField.water,
          scaler: scaler,
        ),
      ),
      TextFormField(
        controller: _ratioController,
        readOnly: _lockedField == _LockedRecipeField.ratio,
        decoration: InputDecoration(
          labelText: 'Ratio',
          prefixText: '1:',
          suffixIcon: _LockButton(
            isLocked: _lockedField == _LockedRecipeField.ratio,
            onPressed: () => setState(() => _lockedField = _LockedRecipeField.ratio),
          ),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        validator: (v) => (double.tryParse(v ?? '') ?? 0) <= 0 ? 'Must be > 0' : null,
        onChanged: (_) => _handleTriLockEdit(
          editedField: _LockedRecipeField.ratio,
          scaler: scaler,
        ),
      ),
      const SizedBox(height: 8),
      Align(
        alignment: Alignment.centerLeft,
        child: FilledButton.icon(
          onPressed: () {
            final result = _rescaleRecipeSteps(scaler);
            if (!context.mounted) return;
            final messenger = ScaffoldMessenger.of(context);
            messenger.hideCurrentSnackBar();
            messenger.showSnackBar(
              SnackBar(
                content: Text(
                  switch (result) {
                    _RecipeRescaleResult.updated => 'Recipe steps readjusted to the current water total.',
                    _RecipeRescaleResult.noSteps => 'No recipe steps to readjust.',
                    _RecipeRescaleResult.noWaterSteps => 'Recipe has no water-bearing steps to readjust.',
                    _RecipeRescaleResult.invalidWaterTotal => 'Enter a valid water total before readjusting the recipe.',
                  },
                ),
              ),
            );
          },
          icon: const Icon(Icons.sync_alt),
          label: const Text('Readjust recipe to totals'),
        ),
      ),
      const SizedBox(height: 16),
      FutureBuilder<List<BrewMethodOption>>(
        future: ref.watch(brewMethodRepositoryProvider).list(),
        builder: (context, methodSnapshot) {
          final methods = methodSnapshot.data ?? const <BrewMethodOption>[];
          if (methods.isNotEmpty && !methods.any((m) => m.name == _method)) {
            _method = methods.first.name;
          }
          return DropdownButtonFormField<String>(
            initialValue: methods.any((m) => m.name == _method)
                ? _method
                : (methods.isEmpty ? null : methods.first.name),
            decoration: const InputDecoration(labelText: 'Method'),
            items: methods
                .map((m) => DropdownMenuItem<String>(value: m.name, child: Text(m.name)))
                .toList(),
            onChanged: (value) => setState(() => _method = value ?? _method),
          );
        },
      ),
      TextFormField(
        controller: _tempController,
        decoration: const InputDecoration(labelText: 'Water temperature (C)'),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
      ),
      TextFormField(
        controller: _waterConditionController,
        decoration: const InputDecoration(labelText: 'Water condition'),
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
              'Recipe steps (${_steps.length})', // • Brew time: ${DisplayFormatters.formatDuration(autoBrewTime)}',
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
                  _steps = RecipeTimeline.normalize([
                    ..._steps,
                    step.copyWith(index: _steps.length),
                  ]);
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
        Builder(
          builder: (context) {
            final recipeWaterTotal = _steps.fold<double>(
              0,
              (sum, step) => sum + (step.waterG ?? 0),
            );
            final targetWater = _tryParsePositive(_waterController.text);
            final difference = targetWater == null ? null : recipeWaterTotal - targetWater;
            final withinRoundingError =
                difference != null && difference.abs() < 0.051;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReorderableListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _steps.length,
                  onReorder: (oldIndex, newIndex) {
                    setState(() {
                      if (newIndex > oldIndex) newIndex -= 1;
                      final step = _steps.removeAt(oldIndex);
                      _steps.insert(newIndex, step);
                      _steps = RecipeTimeline.normalize(_steps);
                    });
                  },
                  itemBuilder: (context, index) {
                    final step = _steps[index];
                    final title = step.type == RecipeStepType.custom &&
                            (step.label?.trim().isNotEmpty ?? false)
                        ? step.label!.trim()
                        : step.type.name;
                    final hasNotes = (step.durationSec != null) ||
                        (step.waterG != null) ||
                        (step.pressureBar != null) ||
                        (step.note != null);
                    return Card(
                      key: ValueKey('step-${step.index}-${step.type.name}-$index'),
                      child: ListTile(
                        title: Text('${index + 1}. $title'),
                        leading: Text(DisplayFormatters.formatDuration(step.startSec)),
                        subtitle: hasNotes
                            ? Text(
                                [
                                  if (step.durationSec != null) '${step.durationSec} s',
                                  if (step.waterG != null)
                                    DisplayFormatters.formatWeight(step.waterG),
                                  if (step.pressureBar != null)
                                    '${step.pressureBar!.toStringAsFixed(1)} bar',
                                  if (step.note != null) step.note,
                                ].join(' • '),
                              )
                            : null,
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
                                  _steps = RecipeTimeline.normalize(_steps);
                                });
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline),
                              onPressed: () {
                                setState(() {
                                  _steps.removeAt(index);
                                  _steps = RecipeTimeline.normalize(_steps);
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
                    );
                  },
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.water_drop_outlined,
                      size: 20,
                      color: withinRoundingError || targetWater == null
                          ? Theme.of(context).colorScheme.onSurfaceVariant
                          : Theme.of(context).colorScheme.error,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      targetWater == null
                          ? DisplayFormatters.formatWeight(recipeWaterTotal)
                          : withinRoundingError
                              ? DisplayFormatters.formatWeight(recipeWaterTotal)
                              : '${DisplayFormatters.formatWeight(recipeWaterTotal)} '
                                  '(${difference! > 0 ? '+' : ''}${DisplayFormatters.formatWeight(difference)})',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: withinRoundingError || targetWater == null
                                ? Theme.of(context).colorScheme.onSurfaceVariant
                                : Theme.of(context).colorScheme.error,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
    ];
  }

  void _syncRatioController(RecipeScaler scaler) {
    final dose = _tryParsePositive(_coffeeDoseController.text);
    final water = _tryParsePositive(_waterController.text);
    if (dose == null || water == null) {
      _ratioController.text = '';
      return;
    }
    _ratioController.text = _formatForField(
      scaler.computeRatio(coffeeDoseG: dose, waterTotalG: water),
    );
  }

  void _handleTriLockEdit({
    required _LockedRecipeField editedField,
    required RecipeScaler scaler,
  }) {
    if (_isApplyingTriLockUpdate || editedField == _lockedField) {
      return;
    }

    final dose = _tryParsePositive(_coffeeDoseController.text);
    final water = _tryParsePositive(_waterController.text);
    final ratio = _tryParsePositive(_ratioController.text);

    switch (_lockedField) {
      case _LockedRecipeField.ratio:
        if (editedField == _LockedRecipeField.dose && dose != null && ratio != null) {
          _applyDerivedValues(water: scaler.computeWater(dose: dose, ratio: ratio));
        } else if (editedField == _LockedRecipeField.water && water != null && dose != null) {
          _applyDerivedValues(ratio: scaler.computeRatio(coffeeDoseG: dose, waterTotalG: water));
        }
      case _LockedRecipeField.water:
        if (editedField == _LockedRecipeField.dose && dose != null && water != null) {
          _applyDerivedValues(ratio: scaler.computeRatio(coffeeDoseG: dose, waterTotalG: water));
        } else if (editedField == _LockedRecipeField.ratio && ratio != null && water != null) {
          _applyDerivedValues(dose: scaler.computeDose(water: water, ratio: ratio));
        }
      case _LockedRecipeField.dose:
        if (editedField == _LockedRecipeField.water && water != null && dose != null) {
          _applyDerivedValues(ratio: scaler.computeRatio(coffeeDoseG: dose, waterTotalG: water));
        } else if (editedField == _LockedRecipeField.ratio && ratio != null && dose != null) {
          _applyDerivedValues(water: scaler.computeWater(dose: dose, ratio: ratio));
        }
    }
  }

  void _applyDerivedValues({
    double? dose,
    double? water,
    double? ratio,
  }) {
    _isApplyingTriLockUpdate = true;
    try {
      if (dose != null) {
        _coffeeDoseController.text = _formatForField(dose);
      }
      if (water != null) {
        _waterController.text = _formatForField(water);
      }
      if (ratio != null) {
        _ratioController.text = _formatForField(ratio);
      }
    } finally {
      _isApplyingTriLockUpdate = false;
    }
    if (mounted) {
      setState(() {});
    }
  }

  _RecipeRescaleResult _rescaleRecipeSteps(RecipeScaler scaler) {
    final targetWater = _tryParsePositive(_waterController.text);
    if (targetWater == null) return _RecipeRescaleResult.invalidWaterTotal;
    if (_steps.isEmpty) return _RecipeRescaleResult.noSteps;

    final hasWaterBearingSteps = _steps.any((step) => step.waterG != null);
    if (!hasWaterBearingSteps) return _RecipeRescaleResult.noWaterSteps;

    final currentStepWaterTotal = _steps.fold<double>(
      0,
      (sum, step) => sum + (step.waterG ?? 0),
    );

    setState(() {
      _steps = scaler.redistributeWater(
        _steps,
        currentStepWaterTotal,
        targetWater,
      );
    });
    return _RecipeRescaleResult.updated;
  }

  double? _tryParsePositive(String raw) {
    final value = double.tryParse(raw.trim());
    if (value == null || value <= 0) return null;
    return value;
  }

  String _formatForField(double value) => value.toStringAsFixed(1);

  List<Widget> _buildResultsTab(BuildContext context) {
    return [
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
    ];
  }

  Future<RecipeStepDraft?> _showStepDialog(
    BuildContext context, {
    RecipeStepDraft? initialStep,
    required int index,
  }) async {
    RecipeStepType type = initialStep?.type ?? RecipeStepType.pour;
    final waterController = TextEditingController(text: initialStep?.waterG?.toString() ?? '');
    final durationController =
        TextEditingController(text: initialStep?.durationSec?.toString() ?? '');
    final noteController = TextEditingController(text: initialStep?.note ?? '');
    final labelController = TextEditingController(text: initialStep?.label ?? '');
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
                    if (type == RecipeStepType.custom)
                      TextField(
                        controller: labelController,
                        decoration: const InputDecoration(labelText: 'Custom label'),
                      ),
                    TextField(
                      controller: waterController,
                      decoration: const InputDecoration(labelText: 'Water (g) optional'),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
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
                        durationSec: int.tryParse(durationController.text),
                        pressureBar: double.tryParse(pressureController.text),
                        label: _clean(labelController.text),
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

  String? _clean(String raw) {
    final trimmed = raw.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  Future<_EntryFormSeed> _buildLoadFuture() async {
    final entryRepository = ref.read(entryRepositoryProvider);
    final templateRepository = ref.read(templateRepositoryProvider);
    if (widget.entryId != null) {
      return _EntryFormSeed(entry: await entryRepository.getById(widget.entryId!));
    }
    if (widget.duplicateFromEntryId != null) {
      return _EntryFormSeed(entry: await entryRepository.getById(widget.duplicateFromEntryId!));
    }
    if (widget.templateId != null) {
      return _EntryFormSeed(template: await templateRepository.getById(widget.templateId!));
    }
    return const _EntryFormSeed();
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
      waterCondition: _clean(_waterConditionController.text),
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
      steps: RecipeTimeline.normalize(_steps),
    );
    if (mounted) context.pop();
  }
}

enum _LockedRecipeField {
  dose,
  water,
  ratio,
}

enum _RecipeRescaleResult {
  updated,
  noSteps,
  noWaterSteps,
  invalidWaterTotal,
}

class _EntryFormSeed {
  const _EntryFormSeed({this.entry, this.template});

  final EntryRecord? entry;
  final TemplateRecord? template;
}

class _LockButton extends StatelessWidget {
  const _LockButton({
    required this.isLocked,
    required this.onPressed,
  });

  final bool isLocked;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: isLocked ? 'Locked' : 'Lock this field',
      onPressed: onPressed,
      icon: Icon(
        isLocked ? Icons.link : Icons.link_off,
        color: isLocked ? Theme.of(context).colorScheme.primary : null,
      ),
    );
  }
}

class _KeepAliveTab extends StatefulWidget {
  const _KeepAliveTab({required this.child});

  final Widget child;

  @override
  State<_KeepAliveTab> createState() => _KeepAliveTabState();
}

class _KeepAliveTabState extends State<_KeepAliveTab>
    with AutomaticKeepAliveClientMixin<_KeepAliveTab> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}
