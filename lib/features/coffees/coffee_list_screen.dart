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

class _CoffeeListScreenState extends ConsumerState<CoffeeListScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  CoffeeSortOption _sort = CoffeeSortOption.updatedAt;
  bool _showSearch = false;
  bool _showArchived = false;
  late final TabController _tabController;
  late Future<_HomeData> _homeDataFuture;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
    _homeDataFuture = _buildHomeDataFuture();
  }

  @override
  void dispose() {
    _tabController
      ..removeListener(_handleTabSelection)
      ..dispose();
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

          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                pinned: true,
                toolbarHeight: _showSearch ? 72 : kToolbarHeight,
                titleSpacing: _showSearch ? 12 : NavigationToolbar.kMiddleSpacing,
                title: _showSearch
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: _AppBarSearchField(
                          controller: _searchController,
                          focusNode: _searchFocusNode,
                          onChanged: (_) => _refreshHomeData(),
                          onClear: () {
                            _searchController.clear();
                            _refreshHomeData();
                          },
                        ),
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
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(56),
                  child: TabBar(
                    controller: _tabController,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 12),
                    tabs: const [
                      Tab(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.coffee_outlined, size: 18),
                            SizedBox(width: 8),
                            Text('Now Brewing'),
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.archive_outlined, size: 18),
                            SizedBox(width: 8),
                            Text('Archived'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            body: TabBarView(
              controller: _tabController,
              children: [
                _CoffeeListTab(
                  key: const PageStorageKey('coffee-list-current'),
                  title: 'Now Brewing',
                  coffees: data.currentCoffees,
                  sortLabel: _sortLabel(_sort),
                  query: _searchController.text.trim(),
                  onClearQuery: () {
                    _searchController.clear();
                    _refreshHomeData();
                  },
                  onSortSelected: (value) {
                    setState(() => _sort = value);
                    _refreshHomeData();
                  },
                  onAddCoffee: () async {
                    await context.push('/coffee/new');
                    _refreshHomeData();
                  },
                  onTapCoffee: (item) async {
                    await context.push('/coffee/${item.coffee.id}');
                    _refreshHomeData();
                  },
                  onEditCoffee: (item) async {
                    await context.push('/coffee/${item.coffee.id}/edit');
                    _refreshHomeData();
                  },
                  onToggleArchived: (item) async {
                    await _toggleCoffeeArchived(repository, item);
                  },
                  onDeleteCoffee: (item) async {
                    await repository.delete(item.coffee.id);
                    _refreshHomeData();
                  },
                ),
                _CoffeeListTab(
                  key: const PageStorageKey('coffee-list-archived'),
                  title: 'Archived',
                  coffees: data.archivedCoffees,
                  sortLabel: _sortLabel(_sort),
                  query: _searchController.text.trim(),
                  onClearQuery: () {
                    _searchController.clear();
                    _refreshHomeData();
                  },
                  onSortSelected: (value) {
                    setState(() => _sort = value);
                    _refreshHomeData();
                  },
                  onAddCoffee: () async {
                    await context.push('/coffee/new');
                    _refreshHomeData();
                  },
                  onTapCoffee: (item) async {
                    await context.push('/coffee/${item.coffee.id}');
                    _refreshHomeData();
                  },
                  onEditCoffee: (item) async {
                    await context.push('/coffee/${item.coffee.id}/edit');
                    _refreshHomeData();
                  },
                  onToggleArchived: (item) async {
                    await _toggleCoffeeArchived(repository, item);
                  },
                  onDeleteCoffee: (item) async {
                    await repository.delete(item.coffee.id);
                    _refreshHomeData();
                  },
                ),
              ],
            ),
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

  void _handleTabSelection() {
    final showArchived = _tabController.index == 1;
    if (showArchived == _showArchived) return;
    setState(() => _showArchived = showArchived);
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
      isArchived: false,
    );
    final archivedCoffees = await repository.list(
      query: _searchController.text,
      sort: _sort,
      isArchived: true,
    );
    final allCoffees = await db.select(db.coffees).get();
    final allEntries = await db.select(db.entries).get();

    final roasterCount = _distinctCount(allCoffees.map((c) => c.roaster));
    final coffeeCount = allCoffees.length;
    final brewMethodCount = _distinctCount(allEntries.map((e) => e.brewMethod));

    return _HomeData(
      currentCoffees: coffees,
      archivedCoffees: archivedCoffees,
      roasterCount: roasterCount,
      coffeeCount: coffeeCount,
      brewMethodCount: brewMethodCount,
    );
  }

  Future<void> _toggleCoffeeArchived(
    CoffeeRepository repository,
    CoffeeRecord item,
  ) async {
    await repository.upsert(
      id: item.coffee.id,
      name: item.coffee.name,
      roaster: item.coffee.roaster,
      country: item.coffee.country,
      region: item.coffee.region,
      farm: item.coffee.farm,
      producer: item.coffee.producer,
      varietal: item.coffee.varietal,
      process: item.coffee.process,
      altitudeM: item.coffee.altitudeM,
      roastDate: item.coffee.roastDate,
      tastingNotes: item.coffee.tastingNotes,
      notes: item.coffee.notes,
      tags: item.tags,
      isArchived: !item.coffee.isArchived,
    );
    _refreshHomeData();
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
    required this.currentCoffees,
    required this.archivedCoffees,
    required this.roasterCount,
    required this.coffeeCount,
    required this.brewMethodCount,
  });

  final List<CoffeeRecord> currentCoffees;
  final List<CoffeeRecord> archivedCoffees;
  final int roasterCount;
  final int coffeeCount;
  final int brewMethodCount;
}

class _CoffeeListTab extends StatelessWidget {
  const _CoffeeListTab({
    super.key,
    required this.title,
    required this.coffees,
    required this.sortLabel,
    required this.query,
    required this.onClearQuery,
    required this.onSortSelected,
    required this.onAddCoffee,
    required this.onTapCoffee,
    required this.onEditCoffee,
    required this.onToggleArchived,
    required this.onDeleteCoffee,
  });

  final String title;
  final List<CoffeeRecord> coffees;
  final String sortLabel;
  final String query;
  final VoidCallback onClearQuery;
  final ValueChanged<CoffeeSortOption> onSortSelected;
  final Future<void> Function() onAddCoffee;
  final Future<void> Function(CoffeeRecord item) onTapCoffee;
  final Future<void> Function(CoffeeRecord item) onEditCoffee;
  final Future<void> Function(CoffeeRecord item) onToggleArchived;
  final Future<void> Function(CoffeeRecord item) onDeleteCoffee;

  @override
  Widget build(BuildContext context) {
    final hasQuery = query.isNotEmpty;
    return ListView(
      key: PageStorageKey('coffee-tab-$title'),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
      children: [
        Row(
          children: [
            Text(
              '$title (${coffees.length})',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Spacer(),
            PopupMenuButton<CoffeeSortOption>(
              onSelected: onSortSelected,
              itemBuilder: (context) => CoffeeSortOption.values
                  .map(
                    (e) => PopupMenuItem(
                      value: e,
                      child: Text(_sortLabelForTab(e)),
                    ),
                  )
                  .toList(),
              child: Chip(
                visualDensity: VisualDensity.compact,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                labelPadding: const EdgeInsets.symmetric(horizontal: 6),
                avatar: const Icon(Icons.sort, size: 18),
                label: Text(sortLabel),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (hasQuery)
          Align(
            alignment: Alignment.centerLeft,
            child: Chip(
              visualDensity: VisualDensity.compact,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              labelPadding: const EdgeInsets.symmetric(horizontal: 6),
              label: Text('Search: $query'),
              onDeleted: onClearQuery,
            ),
          ),
        if (coffees.isEmpty) ...[
          const SizedBox(height: 48),
          _EmptyState(
            hasQuery: hasQuery,
            archiveLabel: title == 'Archived' ? 'archived coffees' : 'current coffees',
            onAddCoffee: onAddCoffee,
          ),
        ] else ...[
          const SizedBox(height: 4),
          for (final item in coffees)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: _CoffeeCard(
                item: item,
                onTap: () => onTapCoffee(item),
                onEdit: () => onEditCoffee(item),
                onToggleArchived: () => onToggleArchived(item),
                onDelete: () => onDeleteCoffee(item),
              ),
            ),
        ],
      ],
    );
  }

  String _sortLabelForTab(CoffeeSortOption sort) {
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

// Kept for a possible return of the global summary metrics; we are not currently
// showing them and have not settled on the right placement in the home layout.
// ignore: unused_element
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
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        autofocus: true,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: 'Search name, roaster, origin, tags',
          isDense: true,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
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
    required this.onToggleArchived,
    required this.onDelete,
  });

  final CoffeeRecord item;
  final VoidCallback onTap;
  final Future<void> Function() onEdit;
  final Future<void> Function() onToggleArchived;
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
                      if (v == 'archive') {
                        await onToggleArchived();
                      }
                      if (v == 'delete') {
                        await onDelete();
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(value: 'edit', child: Text('Edit')),
                      PopupMenuItem(
                        value: 'archive',
                        child: Text(item.coffee.isArchived ? 'Unarchive' : 'Archive'),
                      ),
                      const PopupMenuItem(value: 'delete', child: Text('Delete')),
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
  const _EmptyState({
    required this.hasQuery,
    required this.archiveLabel,
    required this.onAddCoffee,
  });

  final bool hasQuery;
  final String archiveLabel;
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
              hasQuery ? 'No matching coffees' : 'No $archiveLabel yet',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 6),
            Text(
              hasQuery
                  ? 'Try a different search term or clear search.'
                  : _archiveLabelMessage(),
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            if (!hasQuery) ...[
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: archiveLabel == 'current coffees' ? onAddCoffee : null,
                icon: const Icon(Icons.add),
                label: Text(
                  archiveLabel == 'current coffees'
                      ? 'Add first coffee'
                      : 'Add coffee in Now Brewing',
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _archiveLabelMessage() {
    if (archiveLabel == 'archived coffees') {
      return 'Archived coffees will appear here when you move them out of Now Brewing.';
    }
    return 'Add your first coffee to start logging brews.';
  }
}
