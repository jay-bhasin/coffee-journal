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
  WeightUnitSystem _weightUnitSystem = WeightUnitSystem.grams;
  TemperatureUnitSystem _temperatureUnitSystem = TemperatureUnitSystem.celsius;
  bool _loaded = false;

  @override
  Widget build(BuildContext context) {
    final settingsRepo = ref.watch(settingsRepositoryProvider);
    final themeMode = ref.watch(themeModeProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: FutureBuilder<({WeightUnitSystem weight, TemperatureUnitSystem temperature})>(
        future: () async {
          final weight = await settingsRepo.getWeightUnitSystem();
          final temperature = await settingsRepo.getTemperatureUnitSystem();
          return (weight: weight, temperature: temperature);
        }(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting && !_loaded) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!_loaded) {
            final data = snapshot.data;
            _weightUnitSystem = data?.weight ?? WeightUnitSystem.grams;
            _temperatureUnitSystem =
                data?.temperature ?? TemperatureUnitSystem.celsius;
            _loaded = true;
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text('Weight units', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              SegmentedButton<WeightUnitSystem>(
                segments: const [
                  ButtonSegment(value: WeightUnitSystem.grams, label: Text('g')),
                  ButtonSegment(value: WeightUnitSystem.ounces, label: Text('oz')),
                ],
                selected: {_weightUnitSystem},
                onSelectionChanged: (selection) async {
                  setState(() => _weightUnitSystem = selection.first);
                  await settingsRepo.setWeightUnitSystem(_weightUnitSystem);
                  ref.invalidate(weightUnitSystemProvider);
                  ref.invalidate(appDisplayFormatterProvider);
                },
              ),
              const SizedBox(height: 24),
              Text(
                'Temperature units',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              SegmentedButton<TemperatureUnitSystem>(
                segments: const [
                  ButtonSegment(
                    value: TemperatureUnitSystem.celsius,
                    label: Text('°C'),
                  ),
                  ButtonSegment(
                    value: TemperatureUnitSystem.fahrenheit,
                    label: Text('°F'),
                  ),
                ],
                selected: {_temperatureUnitSystem},
                onSelectionChanged: (selection) async {
                  setState(() => _temperatureUnitSystem = selection.first);
                  await settingsRepo.setTemperatureUnitSystem(
                    _temperatureUnitSystem,
                  );
                  ref.invalidate(temperatureUnitSystemProvider);
                  ref.invalidate(appDisplayFormatterProvider);
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
