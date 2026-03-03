import 'package:coffee_journal/core/models/enums.dart';
import 'package:coffee_journal/core/repositories/contracts.dart';
import 'package:coffee_journal/core/db/database_provider.dart';
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

    return Scaffold(
      appBar: AppBar(
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await context.push('/coffee/new');
          if (mounted) setState(() {});
        },
        icon: const Icon(Icons.add),
        label: const Text('Coffee'),
      ),
      body: Column(
        children: [
          if (_showSearch)
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search name, roaster, origin, tags',
                  suffixIcon: IconButton(
                    onPressed: () {
                      _searchController.clear();
                      setState(() {});
                    },
                    icon: const Icon(Icons.clear),
                  ),
                ),
                onChanged: (_) => setState(() {}),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                const Text('Sort'),
                const SizedBox(width: 12),
                DropdownButton<CoffeeSortOption>(
                  value: _sort,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _sort = value);
                    }
                  },
                  items: CoffeeSortOption.values
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(_sortLabel(e)),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
          const Divider(height: 12),
          Expanded(
            child: FutureBuilder<List<CoffeeRecord>>(
              future: repository.list(query: _searchController.text, sort: _sort),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final items = snapshot.data ?? [];
                if (items.isEmpty) {
                  return const Center(child: Text('No coffees yet. Add your first coffee.'));
                }

                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: ListTile(
                        title: Text('${item.coffee.name} - ${item.coffee.roaster}'),
                        subtitle: Text(
                          [
                            if (item.coffee.country != null) item.coffee.country,
                            if (item.coffee.region != null) item.coffee.region,
                            if (item.coffee.varietal != null) item.coffee.varietal,
                            if (item.coffee.roastDate != null)
                              'Roast ${DateFormat.yMMMd().format(item.coffee.roastDate!)}',
                            if (item.tags.isNotEmpty) 'Tags: ${item.tags.join(', ')}',
                          ].whereType<String>().join(' • '),
                        ),
                        trailing: PopupMenuButton<String>(
                          onSelected: (v) async {
                            if (v == 'edit') {
                              await context.push('/coffee/${item.coffee.id}/edit');
                            }
                            if (v == 'delete') {
                              await repository.delete(item.coffee.id);
                            }
                            if (mounted) setState(() {});
                          },
                          itemBuilder: (context) => const [
                            PopupMenuItem(value: 'edit', child: Text('Edit')),
                            PopupMenuItem(value: 'delete', child: Text('Delete')),
                          ],
                        ),
                        onTap: () async {
                          await context.push('/coffee/${item.coffee.id}');
                          if (mounted) setState(() {});
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
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
