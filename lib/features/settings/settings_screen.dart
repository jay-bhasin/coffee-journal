import 'dart:convert';

import 'package:coffee_journal/core/db/database_provider.dart';
import 'package:coffee_journal/core/models/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  UnitSystem _unitSystem = UnitSystem.metric;
  bool _loaded = false;

  final _exportController = TextEditingController();
  final _importController = TextEditingController();

  @override
  void dispose() {
    _exportController.dispose();
    _importController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settingsRepo = ref.watch(settingsRepositoryProvider);
    final backupRepo = ref.watch(backupRepositoryProvider);

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
              Text('Backup', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              FilledButton.icon(
                onPressed: () async {
                  final bundle = await backupRepo.exportBundle();
                  setState(() {
                    _exportController.text = const JsonEncoder.withIndent('  ').convert(bundle);
                  });
                },
                icon: const Icon(Icons.upload_file),
                label: const Text('Generate export JSON'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _exportController,
                maxLines: 10,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Export JSON',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _importController,
                maxLines: 10,
                decoration: const InputDecoration(
                  labelText: 'Import JSON',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  OutlinedButton(
                    onPressed: () async {
                      try {
                        final payload = jsonDecode(_importController.text) as Map<String, dynamic>;
                        final preview = await backupRepo.previewImport(payload);
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Preview: ${preview.coffeeCount} coffees, '
                              '${preview.entryCount} entries, '
                              '${preview.templateCount} templates, '
                              '${preview.conflictCount} conflicts',
                            ),
                          ),
                        );
                      } catch (error) {
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text('Preview failed: $error')));
                      }
                    },
                    child: const Text('Preview import'),
                  ),
                  FilledButton(
                    onPressed: () async {
                      try {
                        final payload = jsonDecode(_importController.text) as Map<String, dynamic>;
                        await backupRepo.importBundle(payload);
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(content: Text('Import complete')));
                      } catch (error) {
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text('Import failed: $error')));
                      }
                    },
                    child: const Text('Run import'),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
