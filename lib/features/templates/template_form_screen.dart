import 'package:coffee_journal/core/db/database_provider.dart';
import 'package:coffee_journal/core/models/enums.dart';
import 'package:coffee_journal/core/models/recipe_step_draft.dart';
import 'package:coffee_journal/core/repositories/contracts.dart';
import 'package:coffee_journal/core/utils/display_formatters.dart';
import 'package:coffee_journal/core/utils/recipe_scaler.dart';
import 'package:coffee_journal/core/utils/recipe_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TemplateFormScreen extends ConsumerStatefulWidget {
  const TemplateFormScreen({super.key, this.templateId});

  final String? templateId;

  @override
  ConsumerState<TemplateFormScreen> createState() => _TemplateFormScreenState();
}

class _TemplateFormScreenState extends ConsumerState<TemplateFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _doseController = TextEditingController();
  final _waterController = TextEditingController();
  final _ratioController = TextEditingController();
  final _tagsController = TextEditingController();

  String? _method;
  List<RecipeStepDraft> _steps = [];
  _LockedRecipeField _lockedField = _LockedRecipeField.ratio;
  bool _isApplyingTriLockUpdate = false;
  bool _loaded = false;
  late Future<TemplateRecord?> _loadFuture;

  @override
  void initState() {
    super.initState();
    _loadFuture = _buildLoadFuture();
  }

  @override
  void didUpdateWidget(covariant TemplateFormScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.templateId != widget.templateId) {
      _loaded = false;
      _loadFuture = _buildLoadFuture();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _doseController.dispose();
    _waterController.dispose();
    _ratioController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final templateRepository = ref.watch(templateRepositoryProvider);
    final brewMethodRepository = ref.watch(brewMethodRepositoryProvider);
    final scaler = ref.watch(recipeScalerProvider);
    final displayFormatter = ref.watch(appDisplayFormatterProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.templateId == null ? 'New template' : 'Edit template'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Center(
              child: FilledButton(
                onPressed: () async => _saveTemplate(templateRepository),
                style: FilledButton.styleFrom(
                  visualDensity: VisualDensity.compact,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                ),
                child: const Text('Save'),
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder<TemplateRecord?>(
        future: _loadFuture,
        builder: (context, templateSnapshot) {
          if (templateSnapshot.connectionState == ConnectionState.waiting &&
              widget.templateId != null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!_loaded && templateSnapshot.data != null) {
            final record = templateSnapshot.data!;
            _nameController.text = record.template.name;
            _doseController.text = record.template.defaultCoffeeDoseG?.toString() ?? '';
            _waterController.text = record.template.defaultWaterTotalG?.toString() ?? '';
            _ratioController.text = '';
            _tagsController.text = record.tags.join(', ');
            _method = record.template.brewMethod;
            _steps = RecipeTimeline.normalize(
              record.steps.map(
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
            _syncRatioController(scaler);
            _loaded = true;
          }

          return FutureBuilder<List<BrewMethodOption>>(
            future: brewMethodRepository.list(),
            builder: (context, methodsSnapshot) {
              final methods = methodsSnapshot.data ?? const <BrewMethodOption>[];
              if (_method == null && methods.isNotEmpty) {
                _method = methods.first.name;
              }
              if (_method != null && methods.isNotEmpty && !methods.any((m) => m.name == _method)) {
                _method = methods.first.name;
              }

              return Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Template name *'),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) return 'Name is required';
                        return null;
                      },
                    ),
                    DropdownButtonFormField<String>(
                      initialValue:
                          methods.any((m) => m.name == _method) ? _method : (methods.isEmpty ? null : methods.first.name),
                      decoration: const InputDecoration(labelText: 'Method'),
                      items: methods
                          .map((m) => DropdownMenuItem<String>(value: m.name, child: Text(m.name)))
                          .toList(),
                      onChanged: (value) => setState(() => _method = value),
                    ),
                    TextFormField(
                      controller: _doseController,
                      readOnly: _lockedField == _LockedRecipeField.dose,
                      decoration: InputDecoration(
                        labelText: 'Coffee dose (g)',
                        suffixIcon: _LockButton(
                          isLocked: _lockedField == _LockedRecipeField.dose,
                          onPressed: () => setState(() => _lockedField = _LockedRecipeField.dose),
                        ),
                      ),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      validator: (v) => _isBlank(v) || (double.tryParse(v ?? '') ?? 0) > 0
                          ? null
                          : 'Must be > 0',
                      onChanged: (_) => _handleTriLockEdit(
                        editedField: _LockedRecipeField.dose,
                        scaler: scaler,
                      ),
                    ),
                    TextFormField(
                      controller: _waterController,
                      readOnly: _lockedField == _LockedRecipeField.water,
                      decoration: InputDecoration(
                        labelText: 'Water total (g)',
                        suffixIcon: _LockButton(
                          isLocked: _lockedField == _LockedRecipeField.water,
                          onPressed: () => setState(() => _lockedField = _LockedRecipeField.water),
                        ),
                      ),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      validator: (v) => _isBlank(v) || (double.tryParse(v ?? '') ?? 0) > 0
                          ? null
                          : 'Must be > 0',
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
                      validator: (v) => _isBlank(v) || (double.tryParse(v ?? '') ?? 0) > 0
                          ? null
                          : 'Must be > 0',
                      onChanged: (_) => _handleTriLockEdit(
                        editedField: _LockedRecipeField.ratio,
                        scaler: scaler,
                      ),
                    ),
                    TextFormField(
                      controller: _tagsController,
                      decoration: const InputDecoration(labelText: 'Tags (comma-separated)'),
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
                                  _RecipeRescaleResult.updated =>
                                    'Recipe steps readjusted to the current water total.',
                                  _RecipeRescaleResult.noSteps =>
                                    'No recipe steps to readjust.',
                                  _RecipeRescaleResult.noWaterSteps =>
                                    'Recipe has no water-bearing steps to readjust.',
                                  _RecipeRescaleResult.invalidWaterTotal =>
                                    'Enter a valid water total before readjusting the recipe.',
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
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Recipe steps (${_steps.length})',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () async {
                            final step = await _showStepDialog(context, index: _steps.length);
                            if (step == null) return;
                            setState(() {
                              _steps = RecipeTimeline.normalize([
                                ..._steps,
                                step.copyWith(index: _steps.length),
                              ]);
                            });
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
                          final difference =
                              targetWater == null ? null : recipeWaterTotal - targetWater;
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
                                    final moved = _steps.removeAt(oldIndex);
                                    _steps.insert(newIndex, moved);
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
                                    key: ValueKey(
                                      'template-step-${step.index}-${step.type.name}-$index',
                                    ),
                                    child: ListTile(
                                      title: Text('${index + 1}. $title'),
                                      leading: Text(
                                        DisplayFormatters.formatDuration(step.startSec),
                                      ),
                                      subtitle: hasNotes
                                          ? Text(
                                              [
                                                if (step.durationSec != null)
                                                  '${step.durationSec} s',
                                                if (step.waterG != null)
                                                  displayFormatter.formatWeight(step.waterG),
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
                                                index: index,
                                                initialStep: step,
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
                                        ? displayFormatter.formatWeight(recipeWaterTotal)
                                        : withinRoundingError
                                            ? displayFormatter.formatWeight(recipeWaterTotal)
                                            : '${displayFormatter.formatWeight(recipeWaterTotal)} '
                                                '(${difference! > 0 ? '+' : ''}${displayFormatter.formatWeight(difference)})',
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
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<RecipeStepDraft?> _showStepDialog(
    BuildContext context, {
    required int index,
    RecipeStepDraft? initialStep,
  }) async {
    RecipeStepType type = initialStep?.type ?? RecipeStepType.pour;
    final waterController = TextEditingController(text: initialStep?.waterG?.toString() ?? '');
    final durationController =
        TextEditingController(text: initialStep?.durationSec?.toString() ?? '');
    final pressureController =
        TextEditingController(text: initialStep?.pressureBar?.toString() ?? '');
    final noteController = TextEditingController(text: initialStep?.note ?? '');
    final labelController = TextEditingController(text: initialStep?.label ?? '');

    return showDialog<RecipeStepDraft>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(initialStep == null ? 'Add step' : 'Edit step'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButtonFormField<RecipeStepType>(
                      initialValue: type,
                      decoration: const InputDecoration(labelText: 'Type'),
                      items: RecipeStepType.values
                          .map((e) => DropdownMenuItem(value: e, child: Text(e.name)))
                          .toList(),
                      onChanged: (value) => setDialogState(() => type = value ?? type),
                    ),
                    if (type == RecipeStepType.custom)
                      TextField(
                        controller: labelController,
                        decoration: const InputDecoration(labelText: 'Custom label'),
                      ),
                    TextField(
                      controller: waterController,
                      decoration: const InputDecoration(labelText: 'Water (g)'),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    ),
                    TextField(
                      controller: durationController,
                      decoration: const InputDecoration(labelText: 'Duration (sec)'),
                      keyboardType: TextInputType.number,
                    ),
                    TextField(
                      controller: pressureController,
                      decoration: const InputDecoration(labelText: 'Pressure (bar)'),
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
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
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
                  child: Text(initialStep == null ? 'Add' : 'Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<TemplateRecord?> _buildLoadFuture() {
    final repository = ref.read(templateRepositoryProvider);
    if (widget.templateId == null) return Future.value(null);
    return repository.getById(widget.templateId!);
  }

  Future<void> _saveTemplate(TemplateRepository repository) async {
    if (!_formKey.currentState!.validate()) return;
    if ((_method ?? '').trim().isEmpty) return;

    await repository.upsert(
      id: widget.templateId,
      name: _nameController.text.trim(),
      scope: TemplateScope.global,
      coffeeId: null,
      brewMethod: _method!,
      defaultCoffeeDoseG: double.tryParse(_doseController.text),
      defaultWaterTotalG: double.tryParse(_waterController.text),
      steps: RecipeTimeline.normalize(_steps),
      tags: _splitTags(_tagsController.text),
    );

    if (mounted) context.pop();
  }

  void _syncRatioController(RecipeScaler scaler) {
    final dose = _tryParsePositive(_doseController.text);
    final water = _tryParsePositive(_waterController.text);
    if (dose == null || water == null) {
      _ratioController.text = '';
      return;
    }
    _ratioController.text = scaler
        .computeRatio(coffeeDoseG: dose, waterTotalG: water)
        .toStringAsFixed(1);
  }

  void _handleTriLockEdit({
    required _LockedRecipeField editedField,
    required RecipeScaler scaler,
  }) {
    if (_isApplyingTriLockUpdate || editedField == _lockedField) {
      return;
    }

    final dose = _tryParsePositive(_doseController.text);
    final water = _tryParsePositive(_waterController.text);
    final ratio = _tryParsePositive(_ratioController.text);

    switch (_lockedField) {
      case _LockedRecipeField.ratio:
        if (editedField == _LockedRecipeField.dose && dose != null && ratio != null) {
          _applyDerivedValues(water: scaler.computeWater(dose: dose, ratio: ratio));
        } else if (editedField == _LockedRecipeField.water && water != null && dose != null) {
          _applyDerivedValues(
            ratio: scaler.computeRatio(coffeeDoseG: dose, waterTotalG: water),
          );
        }
      case _LockedRecipeField.water:
        if (editedField == _LockedRecipeField.dose && dose != null && water != null) {
          _applyDerivedValues(
            ratio: scaler.computeRatio(coffeeDoseG: dose, waterTotalG: water),
          );
        } else if (editedField == _LockedRecipeField.ratio && ratio != null && water != null) {
          _applyDerivedValues(dose: scaler.computeDose(water: water, ratio: ratio));
        }
      case _LockedRecipeField.dose:
        if (editedField == _LockedRecipeField.water && water != null && dose != null) {
          _applyDerivedValues(
            ratio: scaler.computeRatio(coffeeDoseG: dose, waterTotalG: water),
          );
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
        _doseController.text = dose.toStringAsFixed(1);
      }
      if (water != null) {
        _waterController.text = water.toStringAsFixed(1);
      }
      if (ratio != null) {
        _ratioController.text = ratio.toStringAsFixed(1);
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

  List<String> _splitTags(String raw) {
    return raw
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toSet()
        .toList(growable: false);
  }

  String? _clean(String raw) {
    final value = raw.trim();
    return value.isEmpty ? null : value;
  }

  bool _isBlank(String? value) => value == null || value.trim().isEmpty;
}

enum _RecipeRescaleResult {
  updated,
  noSteps,
  noWaterSteps,
  invalidWaterTotal,
}

enum _LockedRecipeField {
  dose,
  water,
  ratio,
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
