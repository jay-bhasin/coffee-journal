import 'package:coffee_journal/core/db/database_provider.dart';
import 'package:coffee_journal/core/models/enums.dart';
import 'package:coffee_journal/core/models/recipe_step_draft.dart';
import 'package:coffee_journal/core/repositories/contracts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TemplatesScreen extends ConsumerStatefulWidget {
  const TemplatesScreen({super.key});

  @override
  ConsumerState<TemplatesScreen> createState() => _TemplatesScreenState();
}

class _TemplatesScreenState extends ConsumerState<TemplatesScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final templateRepo = ref.watch(templateRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe templates'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Global'),
            Tab(text: 'Per coffee'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await _showCreateTemplateDialog(context);
          if (mounted) setState(() {});
        },
        icon: const Icon(Icons.add),
        label: const Text('Template'),
      ),
      body: FutureBuilder(
        future: templateRepo.list(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final templates = snapshot.data ?? [];
          final global = templates.where((t) => t.template.scope == TemplateScope.global.name).toList();
          final perCoffee = templates.where((t) => t.template.scope == TemplateScope.coffee.name).toList();

          return TabBarView(
            controller: _tabController,
            children: [
              _TemplateList(
                items: global,
                onDelete: (id) async {
                  await templateRepo.delete(id);
                  if (mounted) setState(() {});
                },
              ),
              _TemplateList(
                items: perCoffee,
                onDelete: (id) async {
                  await templateRepo.delete(id);
                  if (mounted) setState(() {});
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _showCreateTemplateDialog(BuildContext context) async {
    final coffeeRepository = ref.read(coffeeRepositoryProvider);
    final templateRepository = ref.read(templateRepositoryProvider);
    final coffees = await coffeeRepository.list();

    final nameController = TextEditingController();
    final doseController = TextEditingController();
    final waterController = TextEditingController();
    final tagsController = TextEditingController();
    TemplateScope scope = TemplateScope.global;
    BrewMethod method = BrewMethod.v60;
    String? coffeeId;

    if (!context.mounted) return;

    await showDialog<void>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('New template'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: 'Template name'),
                    ),
                    DropdownButtonFormField<TemplateScope>(
                      initialValue: scope,
                      items: TemplateScope.values
                          .map((e) => DropdownMenuItem(value: e, child: Text(e.name)))
                          .toList(),
                      onChanged: (v) => setDialogState(() => scope = v ?? scope),
                    ),
                    if (scope == TemplateScope.coffee)
                      DropdownButtonFormField<String>(
                        initialValue: coffeeId,
                        hint: const Text('Select coffee'),
                        items: coffees
                            .map(
                              (e) => DropdownMenuItem(
                                value: e.coffee.id,
                                child: Text('${e.coffee.name} - ${e.coffee.roaster}'),
                              ),
                            )
                            .toList(),
                        onChanged: (v) => setDialogState(() => coffeeId = v),
                      ),
                    DropdownButtonFormField<BrewMethod>(
                      initialValue: method,
                      items: BrewMethod.values
                          .map((e) => DropdownMenuItem(value: e, child: Text(e.label)))
                          .toList(),
                      onChanged: (v) => setDialogState(() => method = v ?? method),
                    ),
                    TextField(
                      controller: doseController,
                      decoration: const InputDecoration(labelText: 'Default dose (g)'),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    ),
                    TextField(
                      controller: waterController,
                      decoration: const InputDecoration(labelText: 'Default water (g)'),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    ),
                    TextField(
                      controller: tagsController,
                      decoration: const InputDecoration(labelText: 'Tags (comma-separated)'),
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
                  onPressed: () async {
                    if (nameController.text.trim().isEmpty) return;
                    await templateRepository.upsert(
                      name: nameController.text.trim(),
                      scope: scope,
                      coffeeId: coffeeId,
                      brewMethod: method,
                      defaultCoffeeDoseG: double.tryParse(doseController.text),
                      defaultWaterTotalG: double.tryParse(waterController.text),
                      steps: [
                        RecipeStepDraft(type: RecipeStepType.bloom, index: 0, waterG: 60, durationSec: 30),
                        RecipeStepDraft(type: RecipeStepType.pour, index: 1, waterG: 240, durationSec: 90),
                      ],
                      tags: tagsController.text
                          .split(',')
                          .map((e) => e.trim())
                          .where((e) => e.isNotEmpty)
                          .toList(),
                    );
                    if (context.mounted) Navigator.of(context).pop();
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _TemplateList extends StatelessWidget {
  const _TemplateList({required this.items, required this.onDelete});

  final List<TemplateRecord> items;
  final Future<void> Function(String id) onDelete;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Center(child: Text('No templates in this scope.'));
    }

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: ListTile(
            title: Text(item.template.name),
            subtitle: Text(
              '${item.template.brewMethod} • '
              '${item.template.defaultCoffeeDoseG?.toStringAsFixed(1) ?? '-'}g / '
              '${item.template.defaultWaterTotalG?.toStringAsFixed(1) ?? '-'}g • '
              '${item.steps.length} steps',
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () => onDelete(item.template.id),
            ),
          ),
        );
      },
    );
  }
}
