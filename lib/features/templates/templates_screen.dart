import 'package:coffee_journal/core/db/database_provider.dart';
import 'package:coffee_journal/core/models/enums.dart';
import 'package:coffee_journal/core/models/recipe_step_draft.dart';
import 'package:coffee_journal/core/repositories/contracts.dart';
import 'package:coffee_journal/core/utils/display_formatters.dart';
import 'package:coffee_journal/core/utils/recipe_scaler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TemplatesScreen extends ConsumerStatefulWidget {
  const TemplatesScreen({
    super.key,
    this.isPickerMode = false,
  });

  final bool isPickerMode;

  @override
  ConsumerState<TemplatesScreen> createState() => _TemplatesScreenState();
}

class _TemplatesScreenState extends ConsumerState<TemplatesScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  bool _showSearch = false;

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(appDataRevisionProvider);
    final templateRepo = ref.watch(templateRepositoryProvider);
    final displayFormatter = ref.watch(appDisplayFormatterProvider);
    final scaler = ref.watch(recipeScalerProvider);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: _showSearch ? 72 : kToolbarHeight,
        titleSpacing: _showSearch ? 12 : NavigationToolbar.kMiddleSpacing,
        title: _showSearch
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: _TemplatesSearchField(
                  controller: _searchController,
                  focusNode: _searchFocusNode,
                  onChanged: (_) => setState(() {}),
                  onClear: () {
                    _searchController.clear();
                    setState(() {});
                  },
                ),
              )
            : Text(widget.isPickerMode ? 'Choose template' : 'Recipe templates'),
        actions: [
          if (_showSearch)
            IconButton(
              tooltip: 'Close search',
              onPressed: _closeSearch,
              icon: const Icon(Icons.close),
            )
          else
            IconButton(
              tooltip: 'Search',
              onPressed: _openSearch,
              icon: const Icon(Icons.search),
            ),
        ],
      ),
      floatingActionButton: widget.isPickerMode
          ? null
          : FloatingActionButton.extended(
              onPressed: () async {
                await context.push('/templates/new');
                if (mounted) setState(() {});
              },
              icon: const Icon(Icons.add),
              label: const Text('Template'),
            ),
      body: FutureBuilder<List<TemplateRecord>>(
        future: templateRepo.list(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final templates = (snapshot.data ?? [])
              .where((t) => t.template.scope == TemplateScope.global.name)
              .toList(growable: false);
          final query = _searchController.text.trim().toLowerCase();
          final filtered = query.isEmpty
              ? templates
              : templates
                  .where((item) => _matchesTemplateQuery(item, query))
                  .toList(growable: false);

          return _TemplateList(
            items: filtered,
            displayFormatter: displayFormatter,
            scaler: scaler,
            isPickerMode: widget.isPickerMode,
            query: _searchController.text.trim(),
            onClearQuery: () {
              _searchController.clear();
              setState(() {});
            },
            onDuplicate: (item) async {
              await templateRepo.upsert(
                name: 'Copy of ${item.template.name}',
                scope: TemplateScope.values.firstWhere(
                  (scope) => scope.name == item.template.scope,
                  orElse: () => TemplateScope.global,
                ),
                coffeeId: item.template.coffeeId,
                brewMethod: item.template.brewMethod,
                defaultCoffeeDoseG: item.template.defaultCoffeeDoseG,
                defaultWaterTotalG: item.template.defaultWaterTotalG,
                steps: item.steps
                    .map(
                      (step) => RecipeStepDraft(
                        type: RecipeStepType.values.firstWhere(
                          (type) => type.name == step.type,
                          orElse: () => RecipeStepType.custom,
                        ),
                        index: step.stepIndex,
                        startSec: step.startSec,
                        durationSec: step.durationSec,
                        note: step.note,
                        waterG: step.waterG,
                        flowRateGPerSec: step.flowRateGPerSec,
                        pressureBar: step.pressureBar,
                        count: step.count,
                        tool: step.tool,
                        label: step.label,
                        jsonPayload: step.jsonPayload,
                      ),
                    )
                    .toList(growable: false),
                tags: item.tags,
              );
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Template duplicated')),
              );
              setState(() {});
            },
            onDelete: (id) async {
              await templateRepo.delete(id);
              if (mounted) setState(() {});
            },
            onOpen: (id) async {
              if (widget.isPickerMode) {
                context.pop(id);
                return;
              }
              await context.push('/templates/$id/edit');
              if (mounted) setState(() {});
            },
          );
        },
      ),
    );
  }

  void _openSearch() {
    setState(() => _showSearch = true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _searchFocusNode.requestFocus();
      }
    });
  }

  void _closeSearch() {
    _searchFocusNode.unfocus();
    setState(() {
      _showSearch = false;
      if (_searchController.text.isNotEmpty) {
        _searchController.clear();
      }
    });
  }

  bool _matchesTemplateQuery(TemplateRecord item, String query) {
    final haystacks = <String>[
      item.template.name,
      item.template.brewMethod,
      ...item.tags,
    ];
    return haystacks.any((value) => value.toLowerCase().contains(query));
  }
}

class _TemplateList extends StatelessWidget {
  const _TemplateList({
    required this.items,
    required this.displayFormatter,
    required this.scaler,
    required this.isPickerMode,
    required this.query,
    required this.onClearQuery,
    required this.onDuplicate,
    required this.onDelete,
    required this.onOpen,
  });

  final List<TemplateRecord> items;
  final AppDisplayFormatter displayFormatter;
  final RecipeScaler scaler;
  final bool isPickerMode;
  final String query;
  final VoidCallback onClearQuery;
  final Future<void> Function(TemplateRecord item) onDuplicate;
  final Future<void> Function(String id) onDelete;
  final Future<void> Function(String id) onOpen;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                query.isEmpty ? Icons.description_outlined : Icons.search_off,
                size: 32,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 12),
              Text(
                query.isEmpty
                    ? 'No templates yet.'
                    : 'No templates match "$query".',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              if (query.isEmpty && isPickerMode) ...[
                const SizedBox(height: 8),
                Text(
                  'Create a template first, then come back here to use it for a new entry.',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
              if (query.isNotEmpty) ...[
                const SizedBox(height: 8),
                TextButton(
                  onPressed: onClearQuery,
                  child: const Text('Clear search'),
                ),
              ],
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final dose = item.template.defaultCoffeeDoseG;
        final water = item.template.defaultWaterTotalG;
        final ratio = dose != null && water != null && dose > 0
            ? scaler.computeRatio(coffeeDoseG: dose, waterTotalG: water)
            : null;
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: ListTile(
            onTap: () => onOpen(item.template.id),
            leading: CircleAvatar(
              backgroundColor:
                  Theme.of(context).colorScheme.surfaceContainerHigh,
              foregroundColor: Theme.of(context).colorScheme.onSurface,
              child: Text(
                item.steps.length.toString(),
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
            title: Text(
              item.template.name,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            subtitle: Text(
              '${item.template.brewMethod} • '
              '${dose != null ? displayFormatter.formatWeight(dose) : '-'} / '
              '${water != null ? displayFormatter.formatWeight(water) : '-'}'
              '${ratio != null ? ' (1:${ratio.toStringAsFixed(1)})' : ''}',
            ),
            trailing: isPickerMode
                ? const Icon(Icons.chevron_right)
                : PopupMenuButton<String>(
                    onSelected: (value) async {
                      if (value == 'edit') {
                        await onOpen(item.template.id);
                      } else if (value == 'duplicate') {
                        await onDuplicate(item);
                      } else if (value == 'delete') {
                        await onDelete(item.template.id);
                      }
                    },
                    itemBuilder: (context) => const [
                      PopupMenuItem(value: 'edit', child: Text('Edit')),
                      PopupMenuItem(
                        value: 'duplicate',
                        child: Text('Duplicate'),
                      ),
                      PopupMenuItem(value: 'delete', child: Text('Delete')),
                    ],
                  ),
          ),
        );
      },
    );
  }
}

class _TemplatesSearchField extends StatelessWidget {
  const _TemplatesSearchField({
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.onClear,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(18),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        onChanged: onChanged,
        autofocus: true,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: 'Search templates',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: controller.text.isEmpty
              ? null
              : IconButton(
                  tooltip: 'Clear search',
                  onPressed: onClear,
                  icon: const Icon(Icons.close),
                ),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        ),
      ),
    );
  }
}
