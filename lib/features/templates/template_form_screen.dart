import 'package:coffee_journal/core/db/database_provider.dart';
import 'package:coffee_journal/core/models/enums.dart';
import 'package:coffee_journal/core/models/recipe_step_draft.dart';
import 'package:coffee_journal/core/repositories/contracts.dart';
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
  final _tagsController = TextEditingController();

  String? _method;
  List<RecipeStepDraft> _steps = [];
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
    _tagsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final templateRepository = ref.watch(templateRepositoryProvider);
    final brewMethodRepository = ref.watch(brewMethodRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.templateId == null ? 'New template' : 'Edit template'),
        actions: [
          IconButton(
            tooltip: 'Save template',
            onPressed: () async => _saveTemplate(templateRepository),
            icon: const Icon(Icons.save_outlined),
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
            _tagsController.text = record.tags.join(', ');
            _method = record.template.brewMethod;
            _steps = record.steps
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
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue:
                          methods.any((m) => m.name == _method) ? _method : (methods.isEmpty ? null : methods.first.name),
                      decoration: const InputDecoration(labelText: 'Brew method'),
                      items: methods
                          .map((m) => DropdownMenuItem<String>(value: m.name, child: Text(m.name)))
                          .toList(),
                      onChanged: (value) => setState(() => _method = value),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _doseController,
                      decoration: const InputDecoration(labelText: 'Default dose (g)'),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    ),
                    TextFormField(
                      controller: _waterController,
                      decoration: const InputDecoration(labelText: 'Default water (g)'),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    ),
                    TextFormField(
                      controller: _tagsController,
                      decoration: const InputDecoration(labelText: 'Tags (comma-separated)'),
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
                              _steps = [..._steps, step.copyWith(index: _steps.length)];
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
                      ReorderableListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _steps.length,
                        onReorder: (oldIndex, newIndex) {
                          setState(() {
                            if (newIndex > oldIndex) newIndex -= 1;
                            final moved = _steps.removeAt(oldIndex);
                            _steps.insert(newIndex, moved);
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
                            key: ValueKey('template-step-${step.index}-${step.type.name}-$index'),
                            child: ListTile(
                              title: Text('${index + 1}. ${step.type.name}'),
                              subtitle: Text(
                                [
                                  if (step.waterG != null) '${step.waterG!.toStringAsFixed(1)} g water',
                                  if (step.startSec != null) 'start ${step.startSec}s',
                                  if (step.durationSec != null) 'dur ${step.durationSec}s',
                                  if (step.pressureBar != null)
                                    '${step.pressureBar!.toStringAsFixed(1)} bar',
                                  if (step.note != null && step.note!.trim().isNotEmpty) step.note!,
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
                                        index: index,
                                        initialStep: step,
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
                          );
                        },
                      ),
                    const SizedBox(height: 24),
                    FilledButton(
                      onPressed: () async => _saveTemplate(templateRepository),
                      child: const Text('Save template'),
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
    final startController = TextEditingController(text: initialStep?.startSec?.toString() ?? '');
    final durationController =
        TextEditingController(text: initialStep?.durationSec?.toString() ?? '');
    final pressureController =
        TextEditingController(text: initialStep?.pressureBar?.toString() ?? '');
    final noteController = TextEditingController(text: initialStep?.note ?? '');

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
                    TextField(
                      controller: waterController,
                      decoration: const InputDecoration(labelText: 'Water (g)'),
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
                        startSec: int.tryParse(startController.text),
                        durationSec: int.tryParse(durationController.text),
                        pressureBar: double.tryParse(pressureController.text),
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
      steps: _steps
          .asMap()
          .entries
          .map((e) => e.value.copyWith(index: e.key))
          .toList(growable: false),
      tags: _splitTags(_tagsController.text),
    );

    if (mounted) context.pop();
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
}
