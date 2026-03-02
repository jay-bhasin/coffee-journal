import 'dart:convert';

import 'package:coffee_journal/core/db/database_provider.dart';
import 'package:coffee_journal/core/models/sensory_notes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class EntryDetailScreen extends ConsumerWidget {
  const EntryDetailScreen({super.key, required this.entryId});

  final String entryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repository = ref.watch(entryRepositoryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Entry detail')),
      body: FutureBuilder(
        future: repository.getById(entryId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final item = snapshot.data;
          if (item == null) {
            return const Center(child: Text('Entry not found'));
          }
          final entry = item.entry;
          final sensory = entry.sensoryJson == null
              ? null
              : SensoryNotes.fromJson(jsonDecode(entry.sensoryJson!) as Map<String, dynamic>);

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                DateFormat.yMMMMd().add_Hm().format(entry.brewAt),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text('Method: ${entry.brewMethod}'),
              Text('Dose: ${entry.coffeeDoseG.toStringAsFixed(1)}g'),
              Text('Water: ${entry.waterTotalG.toStringAsFixed(1)}g'),
              Text('Temperature: ${entry.waterTempC?.toStringAsFixed(0) ?? '-'}C'),
              Text('Grinder: ${entry.grinder ?? '-'} ${entry.grindSetting ?? ''}'),
              Text('Brew time: ${entry.brewTimeSecManual ?? entry.brewTimeSecAuto}s'),
              Text('Extraction outcome: ${entry.extractionOutcome}'),
              if (entry.drawdownSec != null) Text('Drawdown: ${entry.drawdownSec}s'),
              if (entry.agitationLevel != null) Text('Agitation: ${entry.agitationLevel}'),
              if (entry.dialInNotes != null) Text('Dial-in notes: ${entry.dialInNotes}'),
              if (entry.miscNotes != null) Text('Misc notes: ${entry.miscNotes}'),
              if (item.tags.isNotEmpty) Text('Tags: ${item.tags.join(', ')}'),
              const Divider(height: 24),
              Text('Recipe', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              ...item.steps.map(
                (step) => Card(
                  child: ListTile(
                    title: Text('${step.stepIndex + 1}. ${step.type}'),
                    subtitle: Text(
                      [
                        if (step.startSec != null) 'Start ${step.startSec}s',
                        if (step.durationSec != null) 'Dur ${step.durationSec}s',
                        if (step.waterG != null) '${step.waterG!.toStringAsFixed(1)}g',
                        if (step.pressureBar != null) '${step.pressureBar!.toStringAsFixed(1)} bar',
                        if (step.note != null) step.note,
                        if (step.label != null) step.label,
                      ].join(' • '),
                    ),
                  ),
                ),
              ),
              if (sensory != null) ...[
                const Divider(height: 24),
                Text('Sensory', style: Theme.of(context).textTheme.titleMedium),
                if (sensory.aroma != null) Text('Aroma: ${sensory.aroma}'),
                if (sensory.flavor != null) Text('Flavor: ${sensory.flavor}'),
                if (sensory.acidity != null) Text('Acidity: ${sensory.acidity}'),
                if (sensory.sweetness != null) Text('Sweetness: ${sensory.sweetness}'),
                if (sensory.body != null) Text('Body: ${sensory.body}'),
                if (sensory.aftertaste != null) Text('Aftertaste: ${sensory.aftertaste}'),
                if (sensory.freeText != null) Text('Notes: ${sensory.freeText}'),
              ],
            ],
          );
        },
      ),
    );
  }
}
