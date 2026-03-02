import 'dart:convert';

import 'package:coffee_journal/core/db/database.dart';
import 'package:coffee_journal/core/models/enums.dart';
import 'package:coffee_journal/core/models/recipe_step_draft.dart';
import 'package:coffee_journal/core/repositories/contracts.dart';
import 'package:coffee_journal/core/search/search_indexer.dart';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

class LocalCoffeeRepository implements CoffeeRepository {
  LocalCoffeeRepository(this._db, this._searchIndexer);

  final AppDatabase _db;
  final SearchIndexer _searchIndexer;
  final Uuid _uuid = const Uuid();

  @override
  Future<void> delete(String id) async {
    await (_db.delete(_db.coffees)..where((tbl) => tbl.id.equals(id))).go();
  }

  @override
  Future<CoffeeRecord?> getById(String id) async {
    final coffee = await (_db.select(_db.coffees)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
    if (coffee == null) return null;
    final tags = await _tagsForCoffee(id);
    return CoffeeRecord(coffee: coffee, tags: tags);
  }

  @override
  Future<List<CoffeeRecord>> list({
    String query = '',
    CoffeeSortOption sort = CoffeeSortOption.updatedAt,
  }) async {
    final normalizedQuery = _searchIndexer.normalize(query);
    final q = _db.select(_db.coffees)
      ..where((tbl) => tbl.isArchived.equals(false));

    if (normalizedQuery.isNotEmpty) {
      q.where((tbl) => tbl.searchText.like('%$normalizedQuery%'));
    }

    switch (sort) {
      case CoffeeSortOption.name:
        q.orderBy([(tbl) => OrderingTerm.asc(tbl.name)]);
      case CoffeeSortOption.roaster:
        q.orderBy([(tbl) => OrderingTerm.asc(tbl.roaster)]);
      case CoffeeSortOption.country:
        q.orderBy([
          (tbl) => OrderingTerm.asc(tbl.country),
          (tbl) => OrderingTerm.asc(tbl.name),
        ]);
      case CoffeeSortOption.roastDate:
        q.orderBy([(tbl) => OrderingTerm.desc(tbl.roastDate)]);
      case CoffeeSortOption.updatedAt:
        q.orderBy([(tbl) => OrderingTerm.desc(tbl.updatedAt)]);
    }

    final coffees = await q.get();
    return Future.wait(
      coffees.map((coffee) async {
        final tags = await _tagsForCoffee(coffee.id);
        return CoffeeRecord(coffee: coffee, tags: tags);
      }),
    );
  }

  @override
  Future<void> upsert({
    String? id,
    required String name,
    required String roaster,
    String? country,
    String? region,
    String? farm,
    String? producer,
    String? varietal,
    String? process,
    double? altitudeM,
    DateTime? roastDate,
    String? tastingNotes,
    List<String> tags = const [],
    bool isArchived = false,
  }) async {
    final now = DateTime.now();
    final entityId = id ?? _uuid.v4();
    final normalizedTags = tags.map(_searchIndexer.normalize).toSet();
    final mergedSearch = _searchIndexer.buildIndex([
      name,
      roaster,
      country,
      region,
      farm,
      producer,
      varietal,
      process,
      tastingNotes,
      ...normalizedTags,
    ]);

    final existing = await (_db.select(_db.coffees)
          ..where((tbl) => tbl.id.equals(entityId)))
        .getSingleOrNull();

    await _db.into(_db.coffees).insertOnConflictUpdate(
          CoffeesCompanion(
            id: Value(entityId),
            name: Value(name),
            roaster: Value(roaster),
            country: Value(country),
            region: Value(region),
            farm: Value(farm),
            producer: Value(producer),
            varietal: Value(varietal),
            process: Value(process),
            altitudeM: Value(altitudeM),
            roastDate: Value(roastDate),
            tastingNotes: Value(tastingNotes),
            isArchived: Value(isArchived),
            searchText: Value(mergedSearch),
            createdAt: Value(existing?.createdAt ?? now),
            updatedAt: Value(now),
          ),
        );

    await _replaceCoffeeTags(entityId, tags);
  }

  Future<void> _replaceCoffeeTags(String coffeeId, List<String> tags) async {
    await (_db.delete(_db.coffeeTags)..where((tbl) => tbl.coffeeId.equals(coffeeId)))
        .go();
    for (final tag in tags) {
      final id = await _upsertTag(tag);
      await _db.into(_db.coffeeTags).insert(
            CoffeeTagsCompanion(
              coffeeId: Value(coffeeId),
              tagId: Value(id),
            ),
            mode: InsertMode.insertOrIgnore,
          );
    }
  }

  Future<String> _upsertTag(String raw) async {
    final name = raw.trim();
    final normalized = _searchIndexer.normalize(name);
    final existing = await (_db.select(_db.tags)
          ..where((tbl) => tbl.normalizedName.equals(normalized)))
        .getSingleOrNull();
    if (existing != null) {
      await (_db.update(_db.tags)..where((tbl) => tbl.id.equals(existing.id))).write(
        TagsCompanion(usageCount: Value(existing.usageCount + 1)),
      );
      return existing.id;
    }

    final id = _uuid.v4();
    await _db.into(_db.tags).insert(
          TagsCompanion(
            id: Value(id),
            name: Value(name),
            normalizedName: Value(normalized),
            usageCount: const Value(1),
          ),
        );
    return id;
  }

  Future<List<String>> _tagsForCoffee(String coffeeId) async {
    final rows = await (_db.select(_db.tags).join([
      innerJoin(_db.coffeeTags, _db.coffeeTags.tagId.equalsExp(_db.tags.id)),
    ])
          ..where(_db.coffeeTags.coffeeId.equals(coffeeId)))
        .get();

    return rows.map((row) => row.readTable(_db.tags).name).toList();
  }
}

class LocalEntryRepository implements EntryRepository {
  LocalEntryRepository(this._db, this._searchIndexer);

  final AppDatabase _db;
  final SearchIndexer _searchIndexer;
  final Uuid _uuid = const Uuid();

  @override
  Future<void> delete(String id) async {
    await (_db.delete(_db.entries)..where((tbl) => tbl.id.equals(id))).go();
  }

  @override
  Future<void> duplicateEntryToNewDay(String entryId, DateTime newDate) async {
    final existing = await getById(entryId);
    if (existing == null) return;
    await upsert(
      coffeeId: existing.entry.coffeeId,
      brewAt: newDate,
      brewMethod: BrewMethod.values
          .firstWhere((e) => e.name == existing.entry.brewMethod, orElse: () => BrewMethod.other),
      isStarred: false,
      coffeeDoseG: existing.entry.coffeeDoseG,
      waterTotalG: existing.entry.waterTotalG,
      waterTempC: existing.entry.waterTempC,
      grinder: existing.entry.grinder,
      grindSetting: existing.entry.grindSetting,
      yieldG: existing.entry.yieldG,
      pressureBar: existing.entry.pressureBar,
      preinfusionSec: existing.entry.preinfusionSec,
      brewTimeSecAuto: existing.entry.brewTimeSecAuto,
      brewTimeSecManual: existing.entry.brewTimeSecManual,
      sensoryJson: existing.entry.sensoryJson,
      dialInNotes: existing.entry.dialInNotes,
      miscNotes: existing.entry.miscNotes,
      agitationLevel: existing.entry.agitationLevel,
      drawdownSec: existing.entry.drawdownSec,
      extractionOutcome: ExtractionOutcome.values.firstWhere(
        (e) => e.name == existing.entry.extractionOutcome,
        orElse: () => ExtractionOutcome.unknown,
      ),
      steps: existing.steps
          .map(
            (s) => RecipeStepDraft(
              type: RecipeStepType.values.firstWhere(
                (e) => e.name == s.type,
                orElse: () => RecipeStepType.custom,
              ),
              index: s.stepIndex,
              startSec: s.startSec,
              durationSec: s.durationSec,
              note: s.note,
              waterG: s.waterG,
              flowRateGPerSec: s.flowRateGPerSec,
              pressureBar: s.pressureBar,
              count: s.count,
              tool: s.tool,
              label: s.label,
              jsonPayload: s.jsonPayload,
            ),
          )
          .toList(),
      tags: existing.tags,
    );
  }

  @override
  Future<EntryRecord?> getById(String id) async {
    final entry = await (_db.select(_db.entries)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
    if (entry == null) return null;

    final steps = await (_db.select(_db.entrySteps)
          ..where((tbl) => tbl.entryId.equals(id))
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.stepIndex)]))
        .get();
    final tags = await _tagsForEntry(id);
    return EntryRecord(entry: entry, steps: steps, tags: tags);
  }

  @override
  Future<List<EntryRecord>> listForCoffee(
    String coffeeId, {
    EntrySortOption sort = EntrySortOption.starredNewest,
    EntryFilter filter = const EntryFilter(),
  }) async {
    final q = _db.select(_db.entries)
      ..where((tbl) => tbl.coffeeId.equals(coffeeId));

    if (filter.method != null) {
      q.where((tbl) => tbl.brewMethod.equals(filter.method!.name));
    }
    if (filter.starredOnly) {
      q.where((tbl) => tbl.isStarred.equals(true));
    }
    if (filter.start != null) {
      q.where((tbl) => tbl.brewAt.isBiggerOrEqualValue(filter.start!));
    }
    if (filter.end != null) {
      q.where((tbl) => tbl.brewAt.isSmallerOrEqualValue(filter.end!));
    }

    if (filter.tag != null && filter.tag!.trim().isNotEmpty) {
      final normalized = _searchIndexer.normalize(filter.tag!);
      final tag = await (_db.select(_db.tags)
            ..where((tbl) => tbl.normalizedName.equals(normalized)))
          .getSingleOrNull();
      if (tag == null) {
        return [];
      }
      final links = await (_db.select(_db.entryTags)
            ..where((tbl) => tbl.tagId.equals(tag.id)))
          .get();
      if (links.isEmpty) {
        return [];
      }
      q.where((tbl) => tbl.id.isIn(links.map((e) => e.entryId).toList()));
    }

    switch (sort) {
      case EntrySortOption.starredNewest:
        q.orderBy([
          (tbl) => OrderingTerm.desc(tbl.isStarred),
          (tbl) => OrderingTerm.desc(tbl.brewAt),
        ]);
      case EntrySortOption.newest:
        q.orderBy([(tbl) => OrderingTerm.desc(tbl.brewAt)]);
      case EntrySortOption.oldest:
        q.orderBy([(tbl) => OrderingTerm.asc(tbl.brewAt)]);
      case EntrySortOption.method:
        q.orderBy([
          (tbl) => OrderingTerm.asc(tbl.brewMethod),
          (tbl) => OrderingTerm.desc(tbl.brewAt),
        ]);
    }

    final rows = await q.get();
    return Future.wait(rows.map((entry) async {
      final steps = await (_db.select(_db.entrySteps)
            ..where((tbl) => tbl.entryId.equals(entry.id))
            ..orderBy([(tbl) => OrderingTerm.asc(tbl.stepIndex)]))
          .get();
      final tags = await _tagsForEntry(entry.id);
      return EntryRecord(entry: entry, steps: steps, tags: tags);
    }));
  }

  @override
  Future<void> upsert({
    String? id,
    required String coffeeId,
    required DateTime brewAt,
    required BrewMethod brewMethod,
    required bool isStarred,
    required double coffeeDoseG,
    required double waterTotalG,
    double? waterTempC,
    String? grinder,
    String? grindSetting,
    double? yieldG,
    double? pressureBar,
    int? preinfusionSec,
    required int brewTimeSecAuto,
    int? brewTimeSecManual,
    String? sensoryJson,
    String? dialInNotes,
    String? miscNotes,
    String? agitationLevel,
    int? drawdownSec,
    required ExtractionOutcome extractionOutcome,
    required List<RecipeStepDraft> steps,
    List<String> tags = const [],
  }) async {
    final now = DateTime.now();
    final entityId = id ?? _uuid.v4();
    final existing = await (_db.select(_db.entries)
          ..where((tbl) => tbl.id.equals(entityId)))
        .getSingleOrNull();

    final searchText = _searchIndexer.buildIndex([
      brewMethod.name,
      grinder,
      grindSetting,
      dialInNotes,
      miscNotes,
      agitationLevel,
      ...tags,
    ]);

    await _db.into(_db.entries).insertOnConflictUpdate(
          EntriesCompanion(
            id: Value(entityId),
            coffeeId: Value(coffeeId),
            brewAt: Value(brewAt),
            brewMethod: Value(brewMethod.name),
            isStarred: Value(isStarred),
            coffeeDoseG: Value(coffeeDoseG),
            waterTotalG: Value(waterTotalG),
            waterTempC: Value(waterTempC),
            grinder: Value(grinder),
            grindSetting: Value(grindSetting),
            yieldG: Value(yieldG),
            pressureBar: Value(pressureBar),
            preinfusionSec: Value(preinfusionSec),
            brewTimeSecAuto: Value(brewTimeSecAuto),
            brewTimeSecManual: Value(brewTimeSecManual),
            sensoryJson: Value(sensoryJson),
            dialInNotes: Value(dialInNotes),
            miscNotes: Value(miscNotes),
            agitationLevel: Value(agitationLevel),
            drawdownSec: Value(drawdownSec),
            extractionOutcome: Value(extractionOutcome.name),
            searchText: Value(searchText),
            createdAt: Value(existing?.createdAt ?? now),
            updatedAt: Value(now),
          ),
        );

    await (_db.delete(_db.entrySteps)..where((tbl) => tbl.entryId.equals(entityId))).go();
    for (final step in steps) {
      await _db.into(_db.entrySteps).insert(
            EntryStepsCompanion(
              id: Value(_uuid.v4()),
              entryId: Value(entityId),
              stepIndex: Value(step.index),
              type: Value(step.type.name),
              startSec: Value(step.startSec),
              durationSec: Value(step.durationSec),
              note: Value(step.note),
              waterG: Value(step.waterG),
              flowRateGPerSec: Value(step.flowRateGPerSec),
              pressureBar: Value(step.pressureBar),
              count: Value(step.count),
              tool: Value(step.tool),
              label: Value(step.label),
              jsonPayload: Value(step.jsonPayload),
            ),
          );
    }

    await _replaceEntryTags(entityId, tags);
  }

  Future<void> _replaceEntryTags(String entryId, List<String> tags) async {
    await (_db.delete(_db.entryTags)..where((tbl) => tbl.entryId.equals(entryId)))
        .go();
    for (final tag in tags) {
      final id = await _upsertTag(tag);
      await _db.into(_db.entryTags).insert(
            EntryTagsCompanion(
              entryId: Value(entryId),
              tagId: Value(id),
            ),
            mode: InsertMode.insertOrIgnore,
          );
    }
  }

  Future<String> _upsertTag(String raw) async {
    final name = raw.trim();
    final normalized = _searchIndexer.normalize(name);
    final existing = await (_db.select(_db.tags)
          ..where((tbl) => tbl.normalizedName.equals(normalized)))
        .getSingleOrNull();
    if (existing != null) {
      await (_db.update(_db.tags)..where((tbl) => tbl.id.equals(existing.id))).write(
        TagsCompanion(usageCount: Value(existing.usageCount + 1)),
      );
      return existing.id;
    }

    final id = _uuid.v4();
    await _db.into(_db.tags).insert(
          TagsCompanion(
            id: Value(id),
            name: Value(name),
            normalizedName: Value(normalized),
            usageCount: const Value(1),
          ),
        );
    return id;
  }

  Future<List<String>> _tagsForEntry(String entryId) async {
    final rows = await (_db.select(_db.tags).join([
      innerJoin(_db.entryTags, _db.entryTags.tagId.equalsExp(_db.tags.id)),
    ])
          ..where(_db.entryTags.entryId.equals(entryId)))
        .get();

    return rows.map((row) => row.readTable(_db.tags).name).toList();
  }
}

class LocalTemplateRepository implements TemplateRepository {
  LocalTemplateRepository(this._db, this._searchIndexer);

  final AppDatabase _db;
  final SearchIndexer _searchIndexer;
  final Uuid _uuid = const Uuid();

  @override
  Future<void> delete(String id) async {
    await (_db.delete(_db.templates)..where((tbl) => tbl.id.equals(id))).go();
  }

  @override
  Future<List<TemplateRecord>> list({String? coffeeId}) async {
    final q = _db.select(_db.templates)
      ..orderBy([(tbl) => OrderingTerm.asc(tbl.name)]);
    if (coffeeId != null) {
      q.where(
        (tbl) => tbl.scope.equals(TemplateScope.global.name) | tbl.coffeeId.equals(coffeeId),
      );
    }
    final templates = await q.get();

    return Future.wait(templates.map((template) async {
      final steps = await (_db.select(_db.templateSteps)
            ..where((tbl) => tbl.templateId.equals(template.id))
            ..orderBy([(tbl) => OrderingTerm.asc(tbl.stepIndex)]))
          .get();
      final tags = await _tagsForTemplate(template.id);
      return TemplateRecord(template: template, steps: steps, tags: tags);
    }));
  }

  @override
  Future<void> upsert({
    String? id,
    required String name,
    required TemplateScope scope,
    String? coffeeId,
    required BrewMethod brewMethod,
    double? defaultCoffeeDoseG,
    double? defaultWaterTotalG,
    required List<RecipeStepDraft> steps,
    List<String> tags = const [],
  }) async {
    final now = DateTime.now();
    final entityId = id ?? _uuid.v4();
    final existing = await (_db.select(_db.templates)
          ..where((tbl) => tbl.id.equals(entityId)))
        .getSingleOrNull();

    await _db.into(_db.templates).insertOnConflictUpdate(
          TemplatesCompanion(
            id: Value(entityId),
            name: Value(name),
            scope: Value(scope.name),
            coffeeId: Value(scope == TemplateScope.coffee ? coffeeId : null),
            brewMethod: Value(brewMethod.name),
            defaultCoffeeDoseG: Value(defaultCoffeeDoseG),
            defaultWaterTotalG: Value(defaultWaterTotalG),
            searchText: Value(_searchIndexer.buildIndex([name, brewMethod.name, ...tags])),
            createdAt: Value(existing?.createdAt ?? now),
            updatedAt: Value(now),
          ),
        );

    await (_db.delete(_db.templateSteps)..where((tbl) => tbl.templateId.equals(entityId)))
        .go();
    for (final step in steps) {
      await _db.into(_db.templateSteps).insert(
            TemplateStepsCompanion(
              id: Value(_uuid.v4()),
              templateId: Value(entityId),
              stepIndex: Value(step.index),
              type: Value(step.type.name),
              startSec: Value(step.startSec),
              durationSec: Value(step.durationSec),
              note: Value(step.note),
              waterG: Value(step.waterG),
              flowRateGPerSec: Value(step.flowRateGPerSec),
              pressureBar: Value(step.pressureBar),
              count: Value(step.count),
              tool: Value(step.tool),
              label: Value(step.label),
              jsonPayload: Value(step.jsonPayload),
            ),
          );
    }

    await _replaceTemplateTags(entityId, tags);
  }

  Future<void> _replaceTemplateTags(String templateId, List<String> tags) async {
    await (_db.delete(_db.templateTags)..where((tbl) => tbl.templateId.equals(templateId)))
        .go();
    for (final tag in tags) {
      final id = await _upsertTag(tag);
      await _db.into(_db.templateTags).insert(
            TemplateTagsCompanion(templateId: Value(templateId), tagId: Value(id)),
            mode: InsertMode.insertOrIgnore,
          );
    }
  }

  Future<String> _upsertTag(String raw) async {
    final name = raw.trim();
    final normalized = _searchIndexer.normalize(name);
    final existing = await (_db.select(_db.tags)
          ..where((tbl) => tbl.normalizedName.equals(normalized)))
        .getSingleOrNull();
    if (existing != null) {
      await (_db.update(_db.tags)..where((tbl) => tbl.id.equals(existing.id))).write(
        TagsCompanion(usageCount: Value(existing.usageCount + 1)),
      );
      return existing.id;
    }

    final id = _uuid.v4();
    await _db.into(_db.tags).insert(
          TagsCompanion(
            id: Value(id),
            name: Value(name),
            normalizedName: Value(normalized),
            usageCount: const Value(1),
          ),
        );
    return id;
  }

  Future<List<String>> _tagsForTemplate(String templateId) async {
    final rows = await (_db.select(_db.tags).join([
      innerJoin(_db.templateTags, _db.templateTags.tagId.equalsExp(_db.tags.id)),
    ])
          ..where(_db.templateTags.templateId.equals(templateId)))
        .get();

    return rows.map((row) => row.readTable(_db.tags).name).toList();
  }
}

class LocalSettingsRepository implements SettingsRepository {
  LocalSettingsRepository(this._db);

  final AppDatabase _db;

  @override
  Future<UnitSystem> getUnitSystem() async {
    final v = await _db.getSetting('unit_system');
    if (v == UnitSystem.imperial.name) {
      return UnitSystem.imperial;
    }
    return UnitSystem.metric;
  }

  @override
  Future<void> setUnitSystem(UnitSystem unitSystem) {
    return _db.upsertSetting('unit_system', unitSystem.name);
  }
}

class LocalBackupRepository implements BackupRepository {
  LocalBackupRepository(this._db);

  final AppDatabase _db;
  final Uuid _uuid = const Uuid();

  static const int schemaVersion = 1;

  @override
  Future<Map<String, dynamic>> exportBundle() async {
    final coffees = await _db.select(_db.coffees).get();
    final entries = await _db.select(_db.entries).get();
    final entrySteps = await _db.select(_db.entrySteps).get();
    final templates = await _db.select(_db.templates).get();
    final templateSteps = await _db.select(_db.templateSteps).get();
    final tags = await _db.select(_db.tags).get();
    final coffeeTags = await _db.select(_db.coffeeTags).get();
    final entryTags = await _db.select(_db.entryTags).get();
    final templateTags = await _db.select(_db.templateTags).get();
    final settings = await _db.select(_db.appSettings).get();

    return {
      'schemaVersion': schemaVersion,
      'exportedAt': DateTime.now().toIso8601String(),
      'coffees': coffees.map(_coffeeToMap).toList(),
      'entries': entries.map(_entryToMap).toList(),
      'entrySteps': entrySteps.map(_entryStepToMap).toList(),
      'templates': templates.map(_templateToMap).toList(),
      'templateSteps': templateSteps.map(_templateStepToMap).toList(),
      'tags': tags.map(_tagToMap).toList(),
      'coffeeTags': coffeeTags.map((e) => {'coffeeId': e.coffeeId, 'tagId': e.tagId}).toList(),
      'entryTags': entryTags.map((e) => {'entryId': e.entryId, 'tagId': e.tagId}).toList(),
      'templateTags':
          templateTags.map((e) => {'templateId': e.templateId, 'tagId': e.tagId}).toList(),
      'settings': settings.map((s) => {'key': s.key, 'value': s.value}).toList(),
    };
  }

  @override
  Future<void> importBundle(Map<String, dynamic> payload) async {
    final preview = await previewImport(payload);
    if (preview.conflictCount < 0) {
      throw StateError('Invalid import payload');
    }

    final idMap = <String, String>{};
    final tagMap = <String, String>{};

    await _db.transaction(() async {
      for (final raw in (payload['tags'] as List<dynamic>? ?? <dynamic>[])) {
        final map = Map<String, dynamic>.from(raw as Map);
        final newId = _uuid.v4();
        final oldId = map['id'] as String;
        tagMap[oldId] = newId;
        await _db.into(_db.tags).insertOnConflictUpdate(
              TagsCompanion(
                id: Value(newId),
                name: Value(map['name'] as String),
                normalizedName: Value('${map['normalizedName']}_$newId'),
                usageCount: Value(map['usageCount'] as int? ?? 0),
              ),
            );
      }

      for (final raw in (payload['coffees'] as List<dynamic>? ?? <dynamic>[])) {
        final map = Map<String, dynamic>.from(raw as Map);
        final newId = _uuid.v4();
        final oldId = map['id'] as String;
        idMap['coffee:$oldId'] = newId;
        await _db.into(_db.coffees).insert(
              CoffeesCompanion(
                id: Value(newId),
                name: Value(map['name'] as String),
                roaster: Value(map['roaster'] as String),
                country: Value(map['country'] as String?),
                region: Value(map['region'] as String?),
                farm: Value(map['farm'] as String?),
                producer: Value(map['producer'] as String?),
                varietal: Value(map['varietal'] as String?),
                process: Value(map['process'] as String?),
                altitudeM: Value((map['altitudeM'] as num?)?.toDouble()),
                roastDate: Value(_parseDate(map['roastDate'])),
                tastingNotes: Value(map['tastingNotes'] as String?),
                isArchived: Value(map['isArchived'] as bool? ?? false),
                searchText: Value(map['searchText'] as String? ?? ''),
                createdAt: Value(_parseDate(map['createdAt']) ?? DateTime.now()),
                updatedAt: Value(_parseDate(map['updatedAt']) ?? DateTime.now()),
              ),
            );
      }

      for (final raw in (payload['entries'] as List<dynamic>? ?? <dynamic>[])) {
        final map = Map<String, dynamic>.from(raw as Map);
        final newId = _uuid.v4();
        final oldId = map['id'] as String;
        idMap['entry:$oldId'] = newId;
        await _db.into(_db.entries).insert(
              EntriesCompanion(
                id: Value(newId),
                coffeeId: Value(idMap['coffee:${map['coffeeId']}']!),
                brewAt: Value(_parseDate(map['brewAt']) ?? DateTime.now()),
                brewMethod: Value(map['brewMethod'] as String),
                isStarred: Value(map['isStarred'] as bool? ?? false),
                coffeeDoseG: Value((map['coffeeDoseG'] as num).toDouble()),
                waterTotalG: Value((map['waterTotalG'] as num).toDouble()),
                waterTempC: Value((map['waterTempC'] as num?)?.toDouble()),
                grinder: Value(map['grinder'] as String?),
                grindSetting: Value(map['grindSetting'] as String?),
                yieldG: Value((map['yieldG'] as num?)?.toDouble()),
                pressureBar: Value((map['pressureBar'] as num?)?.toDouble()),
                preinfusionSec: Value(map['preinfusionSec'] as int?),
                brewTimeSecAuto: Value(map['brewTimeSecAuto'] as int? ?? 0),
                brewTimeSecManual: Value(map['brewTimeSecManual'] as int?),
                sensoryJson: Value(map['sensoryJson'] as String?),
                dialInNotes: Value(map['dialInNotes'] as String?),
                miscNotes: Value(map['miscNotes'] as String?),
                agitationLevel: Value(map['agitationLevel'] as String?),
                drawdownSec: Value(map['drawdownSec'] as int?),
                extractionOutcome: Value(map['extractionOutcome'] as String? ?? 'unknown'),
                searchText: Value(map['searchText'] as String? ?? ''),
                createdAt: Value(_parseDate(map['createdAt']) ?? DateTime.now()),
                updatedAt: Value(_parseDate(map['updatedAt']) ?? DateTime.now()),
              ),
            );
      }

      for (final raw in (payload['templates'] as List<dynamic>? ?? <dynamic>[])) {
        final map = Map<String, dynamic>.from(raw as Map);
        final newId = _uuid.v4();
        final oldId = map['id'] as String;
        idMap['template:$oldId'] = newId;
        await _db.into(_db.templates).insert(
              TemplatesCompanion(
                id: Value(newId),
                name: Value(map['name'] as String),
                scope: Value(map['scope'] as String),
                coffeeId: Value(map['coffeeId'] == null
                    ? null
                    : idMap['coffee:${map['coffeeId']}']),
                brewMethod: Value(map['brewMethod'] as String),
                defaultCoffeeDoseG: Value((map['defaultCoffeeDoseG'] as num?)?.toDouble()),
                defaultWaterTotalG: Value((map['defaultWaterTotalG'] as num?)?.toDouble()),
                searchText: Value(map['searchText'] as String? ?? ''),
                createdAt: Value(_parseDate(map['createdAt']) ?? DateTime.now()),
                updatedAt: Value(_parseDate(map['updatedAt']) ?? DateTime.now()),
              ),
            );
      }

      for (final raw in (payload['entrySteps'] as List<dynamic>? ?? <dynamic>[])) {
        final map = Map<String, dynamic>.from(raw as Map);
        await _db.into(_db.entrySteps).insert(
              EntryStepsCompanion(
                id: Value(_uuid.v4()),
                entryId: Value(idMap['entry:${map['entryId']}']!),
                stepIndex: Value(map['stepIndex'] as int),
                type: Value(map['type'] as String),
                startSec: Value(map['startSec'] as int?),
                durationSec: Value(map['durationSec'] as int?),
                note: Value(map['note'] as String?),
                waterG: Value((map['waterG'] as num?)?.toDouble()),
                flowRateGPerSec: Value((map['flowRateGPerSec'] as num?)?.toDouble()),
                pressureBar: Value((map['pressureBar'] as num?)?.toDouble()),
                count: Value(map['count'] as int?),
                tool: Value(map['tool'] as String?),
                label: Value(map['label'] as String?),
                jsonPayload: Value(map['jsonPayload'] as String?),
              ),
            );
      }

      for (final raw in (payload['templateSteps'] as List<dynamic>? ?? <dynamic>[])) {
        final map = Map<String, dynamic>.from(raw as Map);
        await _db.into(_db.templateSteps).insert(
              TemplateStepsCompanion(
                id: Value(_uuid.v4()),
                templateId: Value(idMap['template:${map['templateId']}']!),
                stepIndex: Value(map['stepIndex'] as int),
                type: Value(map['type'] as String),
                startSec: Value(map['startSec'] as int?),
                durationSec: Value(map['durationSec'] as int?),
                note: Value(map['note'] as String?),
                waterG: Value((map['waterG'] as num?)?.toDouble()),
                flowRateGPerSec: Value((map['flowRateGPerSec'] as num?)?.toDouble()),
                pressureBar: Value((map['pressureBar'] as num?)?.toDouble()),
                count: Value(map['count'] as int?),
                tool: Value(map['tool'] as String?),
                label: Value(map['label'] as String?),
                jsonPayload: Value(map['jsonPayload'] as String?),
              ),
            );
      }

      for (final raw in (payload['coffeeTags'] as List<dynamic>? ?? <dynamic>[])) {
        final map = Map<String, dynamic>.from(raw as Map);
        await _db.into(_db.coffeeTags).insert(
              CoffeeTagsCompanion(
                coffeeId: Value(idMap['coffee:${map['coffeeId']}']!),
                tagId: Value(tagMap[map['tagId'] as String]!),
              ),
              mode: InsertMode.insertOrIgnore,
            );
      }

      for (final raw in (payload['entryTags'] as List<dynamic>? ?? <dynamic>[])) {
        final map = Map<String, dynamic>.from(raw as Map);
        await _db.into(_db.entryTags).insert(
              EntryTagsCompanion(
                entryId: Value(idMap['entry:${map['entryId']}']!),
                tagId: Value(tagMap[map['tagId'] as String]!),
              ),
              mode: InsertMode.insertOrIgnore,
            );
      }

      for (final raw in (payload['templateTags'] as List<dynamic>? ?? <dynamic>[])) {
        final map = Map<String, dynamic>.from(raw as Map);
        await _db.into(_db.templateTags).insert(
              TemplateTagsCompanion(
                templateId: Value(idMap['template:${map['templateId']}']!),
                tagId: Value(tagMap[map['tagId'] as String]!),
              ),
              mode: InsertMode.insertOrIgnore,
            );
      }

      await _db.upsertSetting(
        'import_last_id_map',
        jsonEncode(idMap),
      );
    });
  }

  @override
  Future<ImportPreview> previewImport(Map<String, dynamic> payload) async {
    final version = payload['schemaVersion'];
    if (version is! int || version != schemaVersion) {
      throw StateError('Unsupported schemaVersion: $version');
    }

    final coffees = (payload['coffees'] as List<dynamic>? ?? <dynamic>[]).length;
    final entries = (payload['entries'] as List<dynamic>? ?? <dynamic>[]).length;
    final templates = (payload['templates'] as List<dynamic>? ?? <dynamic>[]).length;
    final tags = (payload['tags'] as List<dynamic>? ?? <dynamic>[]).length;

    final conflictCount = await _countConflicts(payload);

    return ImportPreview(
      coffeeCount: coffees,
      entryCount: entries,
      templateCount: templates,
      tagCount: tags,
      conflictCount: conflictCount,
    );
  }

  Future<int> _countConflicts(Map<String, dynamic> payload) async {
    var conflicts = 0;

    for (final raw in payload['coffees'] as List<dynamic>? ?? <dynamic>[]) {
      final id = (raw as Map)['id'] as String;
      final existing = await (_db.select(_db.coffees)..where((tbl) => tbl.id.equals(id)))
          .getSingleOrNull();
      if (existing != null) conflicts++;
    }
    for (final raw in payload['entries'] as List<dynamic>? ?? <dynamic>[]) {
      final id = (raw as Map)['id'] as String;
      final existing = await (_db.select(_db.entries)..where((tbl) => tbl.id.equals(id)))
          .getSingleOrNull();
      if (existing != null) conflicts++;
    }
    for (final raw in payload['templates'] as List<dynamic>? ?? <dynamic>[]) {
      final id = (raw as Map)['id'] as String;
      final existing = await (_db.select(_db.templates)..where((tbl) => tbl.id.equals(id)))
          .getSingleOrNull();
      if (existing != null) conflicts++;
    }

    return conflicts;
  }

  DateTime? _parseDate(Object? date) {
    if (date is String && date.isNotEmpty) {
      return DateTime.tryParse(date);
    }
    return null;
  }

  Map<String, dynamic> _coffeeToMap(Coffee row) {
    return {
      'id': row.id,
      'name': row.name,
      'roaster': row.roaster,
      'country': row.country,
      'region': row.region,
      'farm': row.farm,
      'producer': row.producer,
      'varietal': row.varietal,
      'process': row.process,
      'altitudeM': row.altitudeM,
      'roastDate': row.roastDate?.toIso8601String(),
      'tastingNotes': row.tastingNotes,
      'isArchived': row.isArchived,
      'searchText': row.searchText,
      'createdAt': row.createdAt.toIso8601String(),
      'updatedAt': row.updatedAt.toIso8601String(),
    };
  }

  Map<String, dynamic> _entryToMap(Entry row) {
    return {
      'id': row.id,
      'coffeeId': row.coffeeId,
      'brewAt': row.brewAt.toIso8601String(),
      'brewMethod': row.brewMethod,
      'isStarred': row.isStarred,
      'coffeeDoseG': row.coffeeDoseG,
      'waterTotalG': row.waterTotalG,
      'waterTempC': row.waterTempC,
      'grinder': row.grinder,
      'grindSetting': row.grindSetting,
      'yieldG': row.yieldG,
      'pressureBar': row.pressureBar,
      'preinfusionSec': row.preinfusionSec,
      'brewTimeSecAuto': row.brewTimeSecAuto,
      'brewTimeSecManual': row.brewTimeSecManual,
      'sensoryJson': row.sensoryJson,
      'dialInNotes': row.dialInNotes,
      'miscNotes': row.miscNotes,
      'agitationLevel': row.agitationLevel,
      'drawdownSec': row.drawdownSec,
      'extractionOutcome': row.extractionOutcome,
      'searchText': row.searchText,
      'createdAt': row.createdAt.toIso8601String(),
      'updatedAt': row.updatedAt.toIso8601String(),
    };
  }

  Map<String, dynamic> _entryStepToMap(EntryStep row) {
    return {
      'id': row.id,
      'entryId': row.entryId,
      'stepIndex': row.stepIndex,
      'type': row.type,
      'startSec': row.startSec,
      'durationSec': row.durationSec,
      'note': row.note,
      'waterG': row.waterG,
      'flowRateGPerSec': row.flowRateGPerSec,
      'pressureBar': row.pressureBar,
      'count': row.count,
      'tool': row.tool,
      'label': row.label,
      'jsonPayload': row.jsonPayload,
    };
  }

  Map<String, dynamic> _templateToMap(Template row) {
    return {
      'id': row.id,
      'name': row.name,
      'scope': row.scope,
      'coffeeId': row.coffeeId,
      'brewMethod': row.brewMethod,
      'defaultCoffeeDoseG': row.defaultCoffeeDoseG,
      'defaultWaterTotalG': row.defaultWaterTotalG,
      'searchText': row.searchText,
      'createdAt': row.createdAt.toIso8601String(),
      'updatedAt': row.updatedAt.toIso8601String(),
    };
  }

  Map<String, dynamic> _templateStepToMap(TemplateStep row) {
    return {
      'id': row.id,
      'templateId': row.templateId,
      'stepIndex': row.stepIndex,
      'type': row.type,
      'startSec': row.startSec,
      'durationSec': row.durationSec,
      'note': row.note,
      'waterG': row.waterG,
      'flowRateGPerSec': row.flowRateGPerSec,
      'pressureBar': row.pressureBar,
      'count': row.count,
      'tool': row.tool,
      'label': row.label,
      'jsonPayload': row.jsonPayload,
    };
  }

  Map<String, dynamic> _tagToMap(Tag row) {
    return {
      'id': row.id,
      'name': row.name,
      'normalizedName': row.normalizedName,
      'usageCount': row.usageCount,
    };
  }
}
