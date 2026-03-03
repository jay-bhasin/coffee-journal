import 'package:coffee_journal/core/db/database_provider.dart';
import 'package:coffee_journal/core/repositories/contracts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BrewMethodsScreen extends ConsumerStatefulWidget {
  const BrewMethodsScreen({super.key});

  @override
  ConsumerState<BrewMethodsScreen> createState() => _BrewMethodsScreenState();
}

class _BrewMethodsScreenState extends ConsumerState<BrewMethodsScreen> {
  static const String _defaultMethodName = 'Unspecified';
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final repository = ref.watch(brewMethodRepositoryProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Brew methods')),
      body: FutureBuilder<List<BrewMethodOption>>(
        future: repository.list(includeInactive: true),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final methods = snapshot.data ?? const <BrewMethodOption>[];
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'New brew method',
                          hintText: 'e.g. Siphon',
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    FilledButton(
                      onPressed: () async {
                        final name = _nameController.text.trim();
                        if (name.isEmpty) return;
                        await repository.upsert(name: name);
                        _nameController.clear();
                        if (mounted) setState(() {});
                      },
                      child: const Text('Add'),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: ListView.builder(
                  itemCount: methods.length,
                  itemBuilder: (context, index) {
                    final method = methods[index];
                    final isDefaultMethod = method.name == _defaultMethodName;
                    return ListTile(
                      key: ValueKey('brew-method-${method.name}'),
                      title: Text(method.name),
                      subtitle: isDefaultMethod ? const Text('Default fallback method') : null,
                      trailing: isDefaultMethod
                          ? const Icon(Icons.lock_outline)
                          : IconButton(
                              icon: const Icon(Icons.delete_outline),
                              onPressed: () async {
                                await repository.delete(method.name);
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
}
