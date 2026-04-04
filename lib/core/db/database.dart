import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class Coffees extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get roaster => text()();
  TextColumn get country => text().nullable()();
  TextColumn get region => text().nullable()();
  TextColumn get farm => text().nullable()();
  TextColumn get producer => text().nullable()();
  TextColumn get varietal => text().nullable()();
  TextColumn get process => text().nullable()();
  TextColumn get altitudeM => text().named('altitude_m').nullable()();
  DateTimeColumn get roastDate => dateTime().nullable()();
  TextColumn get tastingNotes => text().nullable()();
  TextColumn get notes => text().nullable()();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
  TextColumn get searchText => text().withDefault(const Constant(''))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Entries extends Table {
  TextColumn get id => text()();
  TextColumn get coffeeId =>
      text().references(Coffees, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get brewAt => dateTime()();
  TextColumn get brewMethod => text()();
  BoolColumn get isStarred => boolean().withDefault(const Constant(false))();

  RealColumn get coffeeDoseG => real()();
  RealColumn get waterTotalG => real()();
  RealColumn get waterTempC => real().nullable()();
  TextColumn get waterCondition => text().named('water_condition').nullable()();
  TextColumn get grinder => text().nullable()();
  TextColumn get grindSetting => text().nullable()();

  RealColumn get yieldG => real().nullable()();
  RealColumn get pressureBar => real().nullable()();
  IntColumn get preinfusionSec => integer().nullable()();

  IntColumn get brewTimeSecAuto => integer().withDefault(const Constant(0))();
  IntColumn get brewTimeSecManual => integer().nullable()();

  TextColumn get sensoryJson => text().nullable()();
  TextColumn get dialInNotes => text().nullable()();
  TextColumn get miscNotes => text().nullable()();

  TextColumn get agitationLevel => text().nullable()();
  IntColumn get drawdownSec => integer().nullable()();
  TextColumn get extractionOutcome =>
      text().withDefault(const Constant('unknown'))();

  TextColumn get searchText => text().withDefault(const Constant(''))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class EntrySteps extends Table {
  TextColumn get id => text()();
  TextColumn get entryId =>
      text().references(Entries, #id, onDelete: KeyAction.cascade)();
  IntColumn get stepIndex => integer()();
  TextColumn get type => text()();
  IntColumn get startSec => integer().nullable()();
  IntColumn get durationSec => integer().nullable()();
  TextColumn get note => text().nullable()();
  RealColumn get waterG => real().nullable()();
  RealColumn get flowRateGPerSec => real().nullable()();
  RealColumn get pressureBar => real().nullable()();
  IntColumn get count => integer().nullable()();
  TextColumn get tool => text().nullable()();
  TextColumn get label => text().nullable()();
  TextColumn get jsonPayload => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Templates extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get scope => text()();
  TextColumn get coffeeId =>
      text().nullable().references(Coffees, #id, onDelete: KeyAction.cascade)();
  TextColumn get brewMethod => text()();
  RealColumn get defaultCoffeeDoseG => real().nullable()();
  RealColumn get defaultWaterTotalG => real().nullable()();
  TextColumn get searchText => text().withDefault(const Constant(''))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class TemplateSteps extends Table {
  TextColumn get id => text()();
  TextColumn get templateId =>
      text().references(Templates, #id, onDelete: KeyAction.cascade)();
  IntColumn get stepIndex => integer()();
  TextColumn get type => text()();
  IntColumn get startSec => integer().nullable()();
  IntColumn get durationSec => integer().nullable()();
  TextColumn get note => text().nullable()();
  RealColumn get waterG => real().nullable()();
  RealColumn get flowRateGPerSec => real().nullable()();
  RealColumn get pressureBar => real().nullable()();
  IntColumn get count => integer().nullable()();
  TextColumn get tool => text().nullable()();
  TextColumn get label => text().nullable()();
  TextColumn get jsonPayload => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Tags extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get normalizedName => text().unique()();
  IntColumn get usageCount => integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class CoffeeTags extends Table {
  TextColumn get coffeeId =>
      text().references(Coffees, #id, onDelete: KeyAction.cascade)();
  TextColumn get tagId => text().references(Tags, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column<Object>> get primaryKey => {coffeeId, tagId};
}

class EntryTags extends Table {
  TextColumn get entryId =>
      text().references(Entries, #id, onDelete: KeyAction.cascade)();
  TextColumn get tagId => text().references(Tags, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column<Object>> get primaryKey => {entryId, tagId};
}

class TemplateTags extends Table {
  TextColumn get templateId =>
      text().references(Templates, #id, onDelete: KeyAction.cascade)();
  TextColumn get tagId => text().references(Tags, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column<Object>> get primaryKey => {templateId, tagId};
}

class AppSettings extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column<Object>> get primaryKey => {key};
}

class BrewMethods extends Table {
  TextColumn get name => text()();
  IntColumn get sortOrder => integer()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {name};
}

@DriftDatabase(
  tables: [
    Coffees,
    Entries,
    EntrySteps,
    Templates,
    TemplateSteps,
    Tags,
    CoffeeTags,
    EntryTags,
    TemplateTags,
    AppSettings,
    BrewMethods,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await customStatement(
            'CREATE INDEX idx_entries_coffee_brew_at ON entries (coffee_id, brew_at DESC);',
          );
          await customStatement(
            'CREATE INDEX idx_entries_coffee_star_brew ON entries (coffee_id, is_starred DESC, brew_at DESC);',
          );
          await customStatement('CREATE INDEX idx_coffees_roaster ON coffees (roaster);');
          await customStatement('CREATE INDEX idx_coffees_country ON coffees (country);');
          await customStatement('CREATE INDEX idx_coffees_name ON coffees (name);');
          await customStatement(
            'CREATE INDEX idx_entry_steps_entry_step ON entry_steps (entry_id, step_index);',
          );
          await _seedDefaultBrewMethods();
        },
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.createTable(brewMethods);
            await _seedDefaultBrewMethods();
            await _migrateLegacyBrewMethodNames();
          }
          if (from < 3) {
            await _migrateCoffeeAltitudeToText();
          }
          if (from < 4) {
            await customStatement('ALTER TABLE coffees ADD COLUMN notes TEXT;');
            await customStatement(
              'ALTER TABLE entries ADD COLUMN water_condition TEXT;',
            );
          }
        },
      );

  Future<void> upsertSetting(String key, String value) {
    return into(appSettings).insertOnConflictUpdate(
      AppSettingsCompanion(key: Value(key), value: Value(value)),
    );
  }

  Future<String?> getSetting(String key) async {
    final row = await (select(appSettings)..where((tbl) => tbl.key.equals(key)))
        .getSingleOrNull();
    return row?.value;
  }

  Future<void> _seedDefaultBrewMethods() async {
    final now = DateTime.now();
    final defaults = <String>[
      'Aeropress',
      'Chemex',
      'Espresso',
      'French Press',
      'Kalita',
      'Moka',
      'Unspecified',
      'V60',
    ];
    for (var i = 0; i < defaults.length; i++) {
      await into(brewMethods).insert(
        BrewMethodsCompanion(
          name: Value(defaults[i]),
          sortOrder: Value(i),
          isActive: const Value(true),
          createdAt: Value(now),
          updatedAt: Value(now),
        ),
        mode: InsertMode.insertOrIgnore,
      );
    }
  }

  Future<void> _migrateLegacyBrewMethodNames() async {
    const mapping = <String, String>{
      'v60': 'V60',
      'kalita': 'Kalita',
      'chemex': 'Chemex',
      'aeropress': 'Aeropress',
      'frenchPress': 'French Press',
      'espresso': 'Espresso',
      'moka': 'Moka',
      'other': 'Unspecified',
      'Other': 'Unspecified',
    };
    for (final entry in mapping.entries) {
      await customStatement(
        "UPDATE entries SET brew_method = ? WHERE brew_method = ?",
        [entry.value, entry.key],
      );
      await customStatement(
        "UPDATE templates SET brew_method = ? WHERE brew_method = ?",
        [entry.value, entry.key],
      );
    }
  }

  Future<void> _migrateCoffeeAltitudeToText() async {
    await customStatement('PRAGMA foreign_keys = OFF;');
    await customStatement('''
      CREATE TABLE coffees_new (
        id TEXT NOT NULL PRIMARY KEY,
        name TEXT NOT NULL,
        roaster TEXT NOT NULL,
        country TEXT NULL,
        region TEXT NULL,
        farm TEXT NULL,
        producer TEXT NULL,
        varietal TEXT NULL,
        process TEXT NULL,
        altitude_m TEXT NULL,
        roast_date INTEGER NULL,
        tasting_notes TEXT NULL,
        is_archived INTEGER NOT NULL DEFAULT 0,
        search_text TEXT NOT NULL DEFAULT '',
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL
      );
    ''');
    await customStatement('''
      INSERT INTO coffees_new (
        id, name, roaster, country, region, farm, producer, varietal, process,
        altitude_m, roast_date, tasting_notes, is_archived, search_text, created_at, updated_at
      )
      SELECT
        id, name, roaster, country, region, farm, producer, varietal, process,
        CASE WHEN altitude_m IS NULL THEN NULL ELSE CAST(altitude_m AS TEXT) END,
        roast_date, tasting_notes, is_archived, search_text, created_at, updated_at
      FROM coffees;
    ''');
    await customStatement('DROP TABLE coffees;');
    await customStatement('ALTER TABLE coffees_new RENAME TO coffees;');
    await customStatement('CREATE INDEX IF NOT EXISTS idx_coffees_roaster ON coffees (roaster);');
    await customStatement('CREATE INDEX IF NOT EXISTS idx_coffees_country ON coffees (country);');
    await customStatement('CREATE INDEX IF NOT EXISTS idx_coffees_name ON coffees (name);');
    await customStatement('PRAGMA foreign_keys = ON;');
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'coffee_journal.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
