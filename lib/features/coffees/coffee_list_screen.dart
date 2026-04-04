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
  final FocusNode _searchFocusNode = FocusNode();
  CoffeeSortOption _sort = CoffeeSortOption.updatedAt;
  bool _showSearch = false;
  late Future<_HomeData> _homeDataFuture;

  @override
  void initState() {
    super.initState();
    _homeDataFuture = _buildHomeDataFuture();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final repository = ref.watch(coffeeRepositoryProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await context.push('/coffee/new');
          _refreshHomeData();
        },
        icon: const Icon(Icons.add, size: 20),
        label: const Text('Add coffee'),
      ),
      body: FutureBuilder<_HomeData>(
        future: _homeDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              !snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data;
          if (data == null) {
            return const Center(child: Text('Unable to load coffees'));
          }

          final coffees = data.coffees;

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                titleSpacing: _showSearch ? 8 : NavigationToolbar.kMiddleSpacing,
                title: _showSearch
                    ? _AppBarSearchField(
                        controller: _searchController,
                        focusNode: _searchFocusNode,
                        onChanged: (_) => _refreshHomeData(),
                        onClear: () {
                          _searchController.clear();
                          _refreshHomeData();
                        },
                      )
                    : const Text('Coffee Journal'),
                actions: [
                  if (_showSearch)
                    IconButton(
                      tooltip: 'Close search',
                      onPressed: _closeSearch,
                      icon: const Icon(Icons.close),
                    )
                  else ...[
                    IconButton(
                      tooltip: 'Search',
                      onPressed: _openSearch,
                      icon: const Icon(Icons.search),
                    ),
                    IconButton(
                      tooltip: 'Settings',
                      onPressed: () => context.push('/settings'),
                      icon: const Icon(Icons.settings),
                    ),
                  ],
                ],
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
                            onSelected: (value) {
                              setState(() => _sort = value);
                              _refreshHomeData();
                            },
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
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              labelPadding: const EdgeInsets.symmetric(
                                horizontal: 6,
                              ),
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
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                labelPadding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                ),
                                label: Text(
                                  'Search: ${_searchController.text.trim()}',
                                ),
                                onDeleted: () {
                                  _searchController.clear();
                                  _refreshHomeData();
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
                      _refreshHomeData();
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
                            _refreshHomeData();
                          },
                          onEdit: () async {
                            await context.push(
                              '/coffee/${item.coffee.id}/edit',
                            );
                            _refreshHomeData();
                          },
                          onDelete: () async {
                            await repository.delete(item.coffee.id);
                            _refreshHomeData();
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

  void _refreshHomeData() {
    if (!mounted) return;
    setState(() {
      _homeDataFuture = _buildHomeDataFuture();
    });
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
        _homeDataFuture = _buildHomeDataFuture();
      }
    });
  }

  Future<_HomeData> _buildHomeDataFuture() {
    final repository = ref.read(coffeeRepositoryProvider);
    final db = ref.read(appDatabaseProvider);
    return _loadHomeData(repository, db);
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
      case CoffeeSortOption.updatedAt:
        return 'Recent activity';
      case CoffeeSortOption.name:
        return 'Name';
      case CoffeeSortOption.roaster:
        return 'Roaster';
      case CoffeeSortOption.country:
        return 'Origin';
      case CoffeeSortOption.roastDate:
        return 'Roast date';

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
  const _MetricTile({required this.label, required this.value});

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
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

class _AppBarSearchField extends StatelessWidget {
  const _AppBarSearchField({
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
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        autofocus: true,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: 'Search name, roaster, origin, tags',
          isDense: true,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          suffixIcon: controller.text.trim().isNotEmpty
              ? IconButton(
                  tooltip: 'Clear search',
                  onPressed: onClear,
                  icon: const Icon(Icons.close, size: 18),
                )
              : null,
        ),
        onChanged: onChanged,
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
                          style: Theme.of(context).textTheme.titleMedium
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
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          labelPadding: const EdgeInsets.symmetric(
                            horizontal: 6,
                          ),
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
                  if (item.lastEntryAt != null)
                    'Last entry ${DateFormat.yMMMd().format(item.lastEntryAt!)}'
                  else
                    'Last updated ${DateFormat.yMMMd().format(item.coffee.updatedAt)}',
                  // if (_notBlank(item.coffee.altitudeM))
                  //   'Altitude: ${item.coffee.altitudeM!}',
                  if (item.coffee.roastDate != null)
                    'Roasted ${DateFormat.yMMMd().format(item.coffee.roastDate!)}',
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
  const _EmptyState({required this.hasQuery, required this.onAddCoffee});

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
