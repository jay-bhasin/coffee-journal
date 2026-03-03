import 'package:coffee_journal/core/db/database_provider.dart';
import 'package:coffee_journal/core/db/database.dart';
import 'package:coffee_journal/core/models/enums.dart';
import 'package:coffee_journal/core/repositories/contracts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class CoffeeListScreen extends ConsumerStatefulWidget {
  const CoffeeListScreen({super.key});

  @override
  ConsumerState<CoffeeListScreen> createState() => _CoffeeListScreenState();
}

class _CoffeeListScreenState extends ConsumerState<CoffeeListScreen> {
  final TextEditingController _searchController = TextEditingController();
  CoffeeSortOption _sort = CoffeeSortOption.updatedAt;
  bool _showSearch = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final repository = ref.watch(coffeeRepositoryProvider);
    final db = ref.watch(appDatabaseProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await context.push('/coffee/new');
          if (mounted) setState(() {});
        },
        icon: const Icon(Icons.add, size: 20),
        label: const Text('Add coffee'),
      ),
      body: FutureBuilder<_HomeData>(
        future: _loadHomeData(repository, db),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data;
          if (data == null) {
            return const Center(child: Text('Unable to load coffees'));
          }

          final coffees = data.coffees;

          return CustomScrollView(
            slivers: [
              SliverAppBar.large(
                pinned: true,
                title: const Text('Coffee Journal'),
                actions: [
                  IconButton(
                    tooltip: _showSearch ? 'Hide search' : 'Search',
                    onPressed: () {
                      setState(() {
                        _showSearch = !_showSearch;
                        if (!_showSearch && _searchController.text.isNotEmpty) {
                          _searchController.clear();
                        }
                      });
                    },
                    icon: Icon(_showSearch ? Icons.close : Icons.search),
                  ),
                  IconButton(
                    tooltip: 'Settings',
                    onPressed: () => context.push('/settings'),
                    icon: const Icon(Icons.settings),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: AnimatedSize(
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOut,
                  child: _showSearch
                      ? Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                          child: Material(
                            elevation: 1,
                            borderRadius: BorderRadius.circular(16),
                            color: Theme.of(context).colorScheme.surfaceContainerHigh,
                            child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: const Icon(Icons.search),
                                hintText: 'Search name, roaster, origin, tags',
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    _searchController.clear();
                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.clear),
                                ),
                                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                              ),
                              onChanged: (_) => setState(() {}),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _MetricTile(
                              label: 'Roasters',
                              value: data.roasterCount.toString(),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _MetricTile(
                              label: 'Coffees',
                              value: data.coffeeCount.toString(),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _MetricTile(
                              label: 'Brew Methods',
                              value: data.brewMethodCount.toString(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Text(
                            'All Coffees (${coffees.length})',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const Spacer(),
                          PopupMenuButton<CoffeeSortOption>(
                            onSelected: (value) => setState(() => _sort = value),
                            itemBuilder: (context) => CoffeeSortOption.values
                                .map(
                                  (e) => PopupMenuItem(
                                    value: e,
                                    child: Text(_sortLabel(e)),
                                  ),
                                )
                                .toList(),
                            child: Chip(
                              visualDensity: VisualDensity.compact,
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              labelPadding: const EdgeInsets.symmetric(horizontal: 6),
                              avatar: const Icon(Icons.sort, size: 18),
                              label: Text(_sortLabel(_sort)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: [
                            if (_searchController.text.trim().isNotEmpty)
                              Chip(
                                visualDensity: VisualDensity.compact,
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                labelPadding: const EdgeInsets.symmetric(horizontal: 6),
                                label: Text('Search: ${_searchController.text.trim()}'),
                                onDeleted: () {
                                  _searchController.clear();
                                  setState(() {});
                                },
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (coffees.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: _EmptyState(
                    hasQuery: _searchController.text.trim().isNotEmpty,
                    onAddCoffee: () async {
                      await context.push('/coffee/new');
                      if (mounted) setState(() {});
                    },
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 96),
                  sliver: SliverList.builder(
                    itemCount: coffees.length,
                    itemBuilder: (context, index) {
                      final item = coffees[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: _CoffeeCard(
                          item: item,
                          onTap: () async {
                            await context.push('/coffee/${item.coffee.id}');
                            if (mounted) setState(() {});
                          },
                          onEdit: () async {
                            await context.push('/coffee/${item.coffee.id}/edit');
                            if (mounted) setState(() {});
                          },
                          onDelete: () async {
                            await repository.delete(item.coffee.id);
                            if (mounted) setState(() {});
                          },
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

  Future<_HomeData> _loadHomeData(
    CoffeeRepository repository,
    AppDatabase db,
  ) async {
    final coffees = await repository.list(
      query: _searchController.text,
      sort: _sort,
    );
    final allCoffees = await db.select(db.coffees).get();
    final allEntries = await db.select(db.entries).get();

    final roasterCount = _distinctCount(allCoffees.map((c) => c.roaster));
    final coffeeCount = allCoffees.length;
    final brewMethodCount = _distinctCount(allEntries.map((e) => e.brewMethod));

    return _HomeData(
      coffees: coffees,
      roasterCount: roasterCount,
      coffeeCount: coffeeCount,
      brewMethodCount: brewMethodCount,
    );
  }

  int _distinctCount(Iterable<String?> values) {
    return values
        .map((v) => v?.trim())
        .whereType<String>()
        .where((v) => v.isNotEmpty)
        .toSet()
        .length;
  }

  String _sortLabel(CoffeeSortOption sort) {
    switch (sort) {
      case CoffeeSortOption.name:
        return 'Name';
      case CoffeeSortOption.roaster:
        return 'Roaster';
      case CoffeeSortOption.country:
        return 'Country';
      case CoffeeSortOption.roastDate:
        return 'Roast date';
      case CoffeeSortOption.updatedAt:
        return 'Recently updated';
    }
  }
}

class _HomeData {
  const _HomeData({
    required this.coffees,
    required this.roasterCount,
    required this.coffeeCount,
    required this.brewMethodCount,
  });

  final List<CoffeeRecord> coffees;
  final int roasterCount;
  final int coffeeCount;
  final int brewMethodCount;
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.labelSmall),
          const SizedBox(height: 2),
          Text(
            value,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }
}

class _CoffeeCard extends StatelessWidget {
  const _CoffeeCard({
    required this.item,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  final CoffeeRecord item;
  final VoidCallback onTap;
  final Future<void> Function() onEdit;
  final Future<void> Function() onDelete;

  @override
  Widget build(BuildContext context) {
    final country = item.coffee.country?.trim();
    final region = item.coffee.region?.trim();
    final location = switch ((region, country)) {
      (final r?, final c?) when r.isNotEmpty && c.isNotEmpty => '$r, $c',
      (final r?, _) when r.isNotEmpty => r,
      (_, final c?) when c.isNotEmpty => c,
      _ => null,
    };

    final metaChips = <String>[
      if (_notBlank(location)) location!,
      if (_notBlank(item.coffee.varietal)) item.coffee.varietal!,
      if (_notBlank(item.coffee.process)) item.coffee.process!,
    ];

    return Card.filled(
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 14, 10, 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.coffee.name,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item.coffee.roaster,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (v) async {
                      if (v == 'edit') {
                        await onEdit();
                      }
                      if (v == 'delete') {
                        await onDelete();
                      }
                    },
                    itemBuilder: (context) => const [
                      PopupMenuItem(value: 'edit', child: Text('Edit')),
                      PopupMenuItem(value: 'delete', child: Text('Delete')),
                    ],
                  ),
                ],
              ),
              if (metaChips.isNotEmpty) ...[
                const SizedBox(height: 10),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: metaChips
                      .map(
                        (chip) => Chip(
                          visualDensity: VisualDensity.compact,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          labelPadding: const EdgeInsets.symmetric(horizontal: 6),
                          label: Text(chip),
                        ),
                      )
                      .toList(),
                ),
              ],
              const SizedBox(height: 10),
              if (_notBlank(item.coffee.tastingNotes)) ...[
                const SizedBox(height: 10),
                Text(
                  item.coffee.tastingNotes!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
              const SizedBox(height: 8),
              Text(
                [
                  if (_notBlank(item.coffee.altitudeM)) 'Altitude: ${item.coffee.altitudeM!}',
                  if (item.coffee.roastDate != null)
                    'Roast ${DateFormat.yMMMd().format(item.coffee.roastDate!)}',
                  if (item.tags.isNotEmpty) 'Tags: ${item.tags.join(', ')}',
                ].join(' • '),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _notBlank(String? value) => value != null && value.trim().isNotEmpty;
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({
    required this.hasQuery,
    required this.onAddCoffee,
  });

  final bool hasQuery;
  final Future<void> Function() onAddCoffee;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.surfaceContainerHigh,
              ),
              child: const Icon(Icons.coffee, size: 40),
            ),
            const SizedBox(height: 16),
            Text(
              hasQuery ? 'No matching coffees' : 'No coffees yet',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 6),
            Text(
              hasQuery
                  ? 'Try a different search term or clear search.'
                  : 'Add your first coffee to start logging brews.',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            if (!hasQuery) ...[
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: onAddCoffee,
                icon: const Icon(Icons.add),
                label: const Text('Add first coffee'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
