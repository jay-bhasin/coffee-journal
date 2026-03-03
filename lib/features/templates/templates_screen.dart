import 'package:coffee_journal/core/db/database_provider.dart';
import 'package:coffee_journal/core/models/enums.dart';
import 'package:coffee_journal/core/repositories/contracts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TemplatesScreen extends ConsumerStatefulWidget {
  const TemplatesScreen({super.key});

  @override
  ConsumerState<TemplatesScreen> createState() => _TemplatesScreenState();
}

class _TemplatesScreenState extends ConsumerState<TemplatesScreen>
{

  @override
  Widget build(BuildContext context) {
    final templateRepo = ref.watch(templateRepositoryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Recipe templates')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await context.push('/templates/new');
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
          final templates = (snapshot.data ?? [])
              .where((t) => t.template.scope == TemplateScope.global.name)
              .toList(growable: false);

          return _TemplateList(
            items: templates,
            onDelete: (id) async {
              await templateRepo.delete(id);
              if (mounted) setState(() {});
            },
            onOpen: (id) async {
              await context.push('/templates/$id/edit');
              if (mounted) setState(() {});
            },
          );
        },
      ),
    );
  }
}

class _TemplateList extends StatelessWidget {
  const _TemplateList({
    required this.items,
    required this.onDelete,
    required this.onOpen,
  });

  final List<TemplateRecord> items;
  final Future<void> Function(String id) onDelete;
  final Future<void> Function(String id) onOpen;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Center(child: Text('No templates yet.'));
    }

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: ListTile(
            onTap: () => onOpen(item.template.id),
            title: Text(item.template.name),
            subtitle: Text(
              '${item.template.brewMethod} • '
              '${item.template.defaultCoffeeDoseG?.toStringAsFixed(1) ?? '-'}g / '
              '${item.template.defaultWaterTotalG?.toStringAsFixed(1) ?? '-'}g • '
              '${item.steps.length} steps',
            ),
            trailing: PopupMenuButton<String>(
              onSelected: (value) async {
                if (value == 'edit') {
                  await onOpen(item.template.id);
                } else if (value == 'delete') {
                  await onDelete(item.template.id);
                }
              },
              itemBuilder: (context) => const [
                PopupMenuItem(value: 'edit', child: Text('Edit')),
                PopupMenuItem(value: 'delete', child: Text('Delete')),
              ],
            ),
          ),
        );
      },
    );
  }
}
