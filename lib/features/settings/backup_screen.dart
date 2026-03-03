import 'dart:convert';

import 'package:coffee_journal/core/db/database_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BackupScreen extends ConsumerStatefulWidget {
  const BackupScreen({super.key});

  @override
  ConsumerState<BackupScreen> createState() => _BackupScreenState();
}

class _BackupScreenState extends ConsumerState<BackupScreen> {
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
    final backupRepo = ref.watch(backupRepositoryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Backup & Restore')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
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
      ),
    );
  }
}
