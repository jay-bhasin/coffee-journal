import 'package:coffee_journal/core/db/database_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class CoffeeFormScreen extends ConsumerStatefulWidget {
  const CoffeeFormScreen({super.key, this.coffeeId});

  final String? coffeeId;

  @override
  ConsumerState<CoffeeFormScreen> createState() => _CoffeeFormScreenState();
}

class _CoffeeFormScreenState extends ConsumerState<CoffeeFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _roasterController = TextEditingController();
  final _countryController = TextEditingController();
  final _regionController = TextEditingController();
  final _farmController = TextEditingController();
  final _varietalController = TextEditingController();
  final _processController = TextEditingController();
  final _tastingController = TextEditingController();
  final _notesController = TextEditingController();
  final _tagsController = TextEditingController();
  final _altitudeController = TextEditingController();
  DateTime? _roastDate;
  bool _isArchived = false;

  bool _loaded = false;

  @override
  void dispose() {
    _nameController.dispose();
    _roasterController.dispose();
    _countryController.dispose();
    _regionController.dispose();
    _farmController.dispose();
    _varietalController.dispose();
    _processController.dispose();
    _tastingController.dispose();
    _notesController.dispose();
    _tagsController.dispose();
    _altitudeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final repository = ref.watch(coffeeRepositoryProvider);

    return Scaffold(
      appBar: AppBar(title: Text(widget.coffeeId == null ? 'New coffee' : 'Edit coffee')),
      body: FutureBuilder(
        future: widget.coffeeId == null ? Future.value(null) : repository.getById(widget.coffeeId!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting && widget.coffeeId != null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!_loaded && snapshot.data != null) {
            final item = snapshot.data!;
            _nameController.text = item.coffee.name;
            _roasterController.text = item.coffee.roaster;
            _countryController.text = item.coffee.country ?? '';
            _regionController.text = item.coffee.region ?? '';
            _farmController.text = item.coffee.farm ?? '';
            _varietalController.text = item.coffee.varietal ?? '';
            _processController.text = item.coffee.process ?? '';
            _tastingController.text = item.coffee.tastingNotes ?? '';
            _notesController.text = item.coffee.notes ?? '';
            _altitudeController.text = item.coffee.altitudeM?.toString() ?? '';
            _roastDate = item.coffee.roastDate;
            _isArchived = item.coffee.isArchived;
            _tagsController.text = item.tags.join(', ');
            _loaded = true;
          }

          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name *'),
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),
                TextFormField(
                  controller: _roasterController,
                  decoration: const InputDecoration(labelText: 'Roaster *'),
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),
                TextFormField(
                  controller: _countryController,
                  decoration: const InputDecoration(labelText: 'Country'),
                ),
                TextFormField(
                  controller: _regionController,
                  decoration: const InputDecoration(labelText: 'Region'),
                ),
                TextFormField(
                  controller: _farmController,
                  decoration: const InputDecoration(labelText: 'Farm'),
                ),
                TextFormField(
                  controller: _varietalController,
                  decoration: const InputDecoration(labelText: 'Varietal'),
                ),
                TextFormField(
                  controller: _processController,
                  decoration: const InputDecoration(labelText: 'Process'),
                ),
                TextFormField(
                  controller: _altitudeController,
                  decoration: const InputDecoration(labelText: 'Altitude'),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Roast date'),
                  subtitle: Text(
                    _roastDate == null ? 'Not set' : DateFormat.yMMMd().format(_roastDate!),
                  ),
                  trailing: Wrap(
                    spacing: 8,
                    children: [
                      IconButton(
                        tooltip: 'Pick roast date',
                        onPressed: () async {
                          final now = DateTime.now();
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: _roastDate ?? now,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(now.year + 2),
                          );
                          if (picked != null && mounted) {
                            setState(() => _roastDate = picked);
                          }
                        },
                        icon: const Icon(Icons.calendar_today_outlined),
                      ),
                      if (_roastDate != null)
                        IconButton(
                          tooltip: 'Clear roast date',
                          onPressed: () => setState(() => _roastDate = null),
                          icon: const Icon(Icons.clear),
                        ),
                    ],
                  ),
                ),
                TextFormField(
                  controller: _tastingController,
                  minLines: 2,
                  maxLines: 4,
                  decoration: const InputDecoration(labelText: 'Tasting notes'),
                ),
                TextFormField(
                  controller: _notesController,
                  minLines: 2,
                  maxLines: 4,
                  decoration: const InputDecoration(labelText: 'Notes'),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Archived'),
                  value: _isArchived,
                  onChanged: (value) => setState(() => _isArchived = value),
                ),
                TextFormField(
                  controller: _tagsController,
                  decoration: const InputDecoration(labelText: 'Tags (comma-separated)'),
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) return;
                    await repository.upsert(
                      id: widget.coffeeId,
                      name: _nameController.text.trim(),
                      roaster: _roasterController.text.trim(),
                      country: _countryController.text.trim().isEmpty ? null : _countryController.text.trim(),
                      region: _regionController.text.trim().isEmpty ? null : _regionController.text.trim(),
                      farm: _farmController.text.trim().isEmpty ? null : _farmController.text.trim(),
                      varietal:
                          _varietalController.text.trim().isEmpty ? null : _varietalController.text.trim(),
                      process: _processController.text.trim().isEmpty ? null : _processController.text.trim(),
                      altitudeM:
                          _altitudeController.text.trim().isEmpty ? null : _altitudeController.text.trim(),
                      roastDate: _roastDate,
                      tastingNotes:
                          _tastingController.text.trim().isEmpty ? null : _tastingController.text.trim(),
                      notes:
                          _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
                      tags: _splitTags(_tagsController.text),
                      isArchived: _isArchived,
                    );
                    if (context.mounted) context.pop();
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<String> _splitTags(String raw) {
    return raw
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toSet()
        .toList();
  }
}
