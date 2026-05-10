import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:coffee_journal/core/db/database_provider.dart';
import 'package:coffee_journal/core/repositories/contracts.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class BackupScreen extends ConsumerStatefulWidget {
  const BackupScreen({super.key});

  @override
  ConsumerState<BackupScreen> createState() => _BackupScreenState();
}

class _BackupScreenState extends ConsumerState<BackupScreen> {
  bool _isExporting = false;
  bool _isPickingImportFile = false;
  bool _isImporting = false;

  String? _selectedImportFileName;
  ImportPreview? _importPreview;
  Map<String, dynamic>? _importPayload;

  @override
  Widget build(BuildContext context) {
    final backupRepo = ref.watch(backupRepositoryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Backup & Import Data')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SectionCard(
            title: 'Backup',
            description:
                'Create a JSON backup and send it to Files, Drive, email, or any other destination through the device share sheet.',
            child: FilledButton.icon(
              onPressed: _isExporting ? null : () => _shareBackupFile(backupRepo),
              icon: _isExporting
                  ? const SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.ios_share),
              label: Text(_isExporting ? 'Preparing backup...' : 'Share backup file'),
            ),
          ),
          const SizedBox(height: 16),
          _SectionCard(
            title: 'Import data',
            description:
                'Choose a JSON export file from the device, review its contents, then import it into the current database.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'This does not replace existing data. Imported coffees, entries, and templates will be added alongside what is already in the app.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: _isPickingImportFile ? null : () => _pickImportFile(backupRepo),
                  icon: _isPickingImportFile
                      ? const SizedBox.square(
                          dimension: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.folder_open),
                  label: Text(
                    _isPickingImportFile ? 'Opening file picker...' : 'Choose backup file',
                  ),
                ),
                if (_selectedImportFileName != null) ...[
                  const SizedBox(height: 16),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.description_outlined),
                    title: Text(_selectedImportFileName!),
                    subtitle: _importPreview == null
                        ? const Text('No preview available yet')
                        : Text(_previewSummary(_importPreview!)),
                  ),
                ],
                if (_importPreview != null) ...[
                  const SizedBox(height: 8),
                  _PreviewChips(preview: _importPreview!),
                ],
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: _isImporting || _importPayload == null
                      ? null
                      : () => _runImport(backupRepo),
                  icon: _isImporting
                      ? const SizedBox.square(
                          dimension: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.settings_backup_restore),
                  label: Text(_isImporting ? 'Importing...' : 'Import from file'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _shareBackupFile(BackupRepository backupRepo) async {
    setState(() => _isExporting = true);

    try {
      final bundle = await backupRepo.exportBundle();
      final encoder = const JsonEncoder.withIndent('  ');
      final payload = encoder.convert(bundle);
      final tempDir = await getTemporaryDirectory();
      final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
      final file = File(p.join(tempDir.path, 'coffee_journal_backup_$timestamp.json'));
      await file.writeAsString(payload);

      if (!mounted) return;
      final box = context.findRenderObject() as RenderBox?;
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(file.path, mimeType: 'application/json')],
          subject: 'Coffee Journal backup',
          text: 'Coffee Journal backup exported on ${DateFormat.yMMMd().add_jm().format(DateTime.now())}',
          sharePositionOrigin: box == null ? null : box.localToGlobal(Offset.zero) & box.size,
        ),
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Backup export failed: $error')));
    } finally {
      if (mounted) {
        setState(() => _isExporting = false);
      }
    }
  }

  Future<void> _pickImportFile(BackupRepository backupRepo) async {
    setState(() => _isPickingImportFile = true);

    try {
      final result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: const ['json'],
        withData: true,
      );

      if (result == null || result.files.isEmpty) {
        return;
      }

      final file = result.files.single;
      final payload = await _decodeImportPayload(file);
      final preview = await backupRepo.previewImport(payload);

      if (!mounted) return;
      setState(() {
        _selectedImportFileName = file.name;
        _importPayload = payload;
        _importPreview = preview;
      });
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Could not read backup file: $error')));
    } finally {
      if (mounted) {
        setState(() => _isPickingImportFile = false);
      }
    }
  }

  Future<Map<String, dynamic>> _decodeImportPayload(PlatformFile file) async {
    final bytes = file.bytes ?? await _readBytesFromPath(file.path);
    if (bytes == null) {
      throw const FormatException('Selected file could not be read.');
    }

    final decoded = jsonDecode(utf8.decode(bytes));
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('Backup file is not a valid JSON object.');
    }

    return decoded;
  }

  Future<Uint8List?> _readBytesFromPath(String? path) async {
    if (path == null) return null;
    return File(path).readAsBytes();
  }

  Future<void> _runImport(BackupRepository backupRepo) async {
    final payload = _importPayload;
    if (payload == null) return;

    setState(() => _isImporting = true);

    try {
      await backupRepo.importBundle(payload);
      ref.read(appDataRevisionProvider.notifier).bump();
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        const SnackBar(content: Text('Import complete. Existing data was left in place.')),
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Import failed: $error')));
    } finally {
      if (mounted) {
        setState(() => _isImporting = false);
      }
    }
  }

  String _previewSummary(ImportPreview preview) {
    return '${preview.coffeeCount} coffees, ${preview.entryCount} entries, '
        '${preview.templateCount} templates, ${preview.conflictCount} conflicts';
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.description,
    required this.child,
  });

  final String title;
  final String description;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(description),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}

class _PreviewChips extends StatelessWidget {
  const _PreviewChips({required this.preview});

  final ImportPreview preview;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _CountChip(label: 'Coffees', value: preview.coffeeCount),
        _CountChip(label: 'Entries', value: preview.entryCount),
        _CountChip(label: 'Templates', value: preview.templateCount),
        _CountChip(label: 'Conflicts', value: preview.conflictCount),
      ],
    );
  }
}

class _CountChip extends StatelessWidget {
  const _CountChip({required this.label, required this.value});

  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Chip(label: Text('$label: $value'));
  }
}
