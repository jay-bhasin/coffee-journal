import 'package:coffee_journal/core/db/database_provider.dart';
import 'package:coffee_journal/core/models/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  UnitSystem _unitSystem = UnitSystem.metric;
  bool _loaded = false;

  @override
  Widget build(BuildContext context) {
    final settingsRepo = ref.watch(settingsRepositoryProvider);
    final themeMode = ref.watch(themeModeProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: FutureBuilder<UnitSystem>(
        future: settingsRepo.getUnitSystem(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting && !_loaded) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!_loaded) {
            _unitSystem = snapshot.data ?? UnitSystem.metric;
            _loaded = true;
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text('Units', style: Theme.of(context).textTheme.titleMedium),
              SegmentedButton<UnitSystem>(
                segments: const [
                  ButtonSegment(value: UnitSystem.metric, label: Text('Metric')),
                  ButtonSegment(value: UnitSystem.imperial, label: Text('Imperial')),
                ],
                selected: {_unitSystem},
                onSelectionChanged: (selection) async {
                  setState(() => _unitSystem = selection.first);
                  await settingsRepo.setUnitSystem(_unitSystem);
                },
              ),
              const Divider(height: 32),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Dark mode'),
                value: themeMode == ThemeMode.dark,
                onChanged: (enabled) async {
                  await ref.read(themeModeProvider.notifier).setDarkModeEnabled(enabled);
                },
              ),
              const Divider(height: 32),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Manage brew methods'),
                subtitle: const Text('Add or delete brew methods'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push('/brew-methods'),
              ),
              const Divider(height: 32),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Recipe templates'),
                subtitle: const Text('Create and manage recipe templates'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push('/templates'),
              ),
              const Divider(height: 32),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Backup & Restore'),
                subtitle: const Text('Export or import app data'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push('/backup'),
              ),
            ],
          );
        },
      ),
    );
  }
}
