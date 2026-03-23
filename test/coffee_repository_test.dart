import 'package:coffee_journal/core/db/database.dart';
import 'package:coffee_journal/core/models/enums.dart';
import 'package:coffee_journal/core/repositories/local_repositories.dart';
import 'package:coffee_journal/core/search/search_indexer.dart';
import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late LocalCoffeeRepository repository;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repository = LocalCoffeeRepository(db, const SearchIndexer());
  });

  tearDown(() async {
    await db.close();
  });

  test('list sorts by recent activity and exposes lastEntryAt', () async {
    final now = DateTime(2026, 3, 23, 9);
    await _insertCoffee(
      db,
      id: 'a',
      name: 'Alpha',
      updatedAt: now.subtract(const Duration(days: 20)),
    );
    await _insertCoffee(
      db,
      id: 'b',
      name: 'Beta',
      updatedAt: now.subtract(const Duration(days: 10)),
    );
    await _insertCoffee(db, id: 'c', name: 'Gamma', updatedAt: now);
    await _insertCoffee(
      db,
      id: 'd',
      name: 'Delta',
      updatedAt: now.subtract(const Duration(days: 5)),
    );

    await _insertEntry(
      db,
      id: 'entry-a-old',
      coffeeId: 'a',
      brewAt: now.subtract(const Duration(days: 3)),
    );
    await _insertEntry(
      db,
      id: 'entry-a-new',
      coffeeId: 'a',
      brewAt: now.subtract(const Duration(days: 1)),
    );
    await _insertEntry(db, id: 'entry-b', coffeeId: 'b', brewAt: now);

    final coffees = await repository.list(sort: CoffeeSortOption.updatedAt);

    expect(coffees.map((record) => record.coffee.id), ['b', 'c', 'a', 'd']);
    expect(coffees[0].lastEntryAt, now);
    expect(coffees[1].lastEntryAt, isNull);
    expect(coffees[2].lastEntryAt, now.subtract(const Duration(days: 1)));
    expect(coffees[3].lastEntryAt, isNull);
  });

  test('getById returns latest brewAt as lastEntryAt', () async {
    final firstBrew = DateTime(2026, 2, 10, 8);
    final latestBrew = DateTime(2026, 2, 18, 7, 30);
    await _insertCoffee(db, id: 'coffee-1', name: 'Solo');
    await _insertEntry(
      db,
      id: 'entry-1',
      coffeeId: 'coffee-1',
      brewAt: firstBrew,
    );
    await _insertEntry(
      db,
      id: 'entry-2',
      coffeeId: 'coffee-1',
      brewAt: latestBrew,
    );

    final coffee = await repository.getById('coffee-1');

    expect(coffee, isNotNull);
    expect(coffee!.lastEntryAt, latestBrew);
  });

  test('non-updatedAt sorts still use their existing ordering', () async {
    await _insertCoffee(db, id: 'coffee-2', name: 'Zulu', roaster: 'B Roaster');
    await _insertCoffee(
      db,
      id: 'coffee-1',
      name: 'Alpha',
      roaster: 'A Roaster',
    );

    final coffees = await repository.list(sort: CoffeeSortOption.name);

    expect(coffees.map((record) => record.coffee.name), ['Alpha', 'Zulu']);
  });

  test(
    'recent activity falls back to updatedAt for coffees without entries',
    () async {
      final recent = DateTime(2026, 3, 23, 11);
      final older = DateTime(2026, 3, 20, 11);
      await _insertCoffee(db, id: 'newer', name: 'Zulu', updatedAt: recent);
      await _insertCoffee(db, id: 'older', name: 'Alpha', updatedAt: older);

      final coffees = await repository.list(sort: CoffeeSortOption.updatedAt);

      expect(coffees.map((record) => record.coffee.id), ['newer', 'older']);
    },
  );

  test('recent activity tie breaks by alphabetical name', () async {
    final sameTime = DateTime(2026, 3, 23, 11);
    await _insertCoffee(db, id: 'zulu', name: 'Zulu', updatedAt: sameTime);
    await _insertCoffee(db, id: 'alpha', name: 'Alpha', updatedAt: sameTime);

    final coffees = await repository.list(sort: CoffeeSortOption.updatedAt);

    expect(coffees.map((record) => record.coffee.name), ['Alpha', 'Zulu']);
  });
}

Future<void> _insertCoffee(
  AppDatabase db, {
  required String id,
  required String name,
  String roaster = 'Roaster',
  DateTime? updatedAt,
}) {
  final now = updatedAt ?? DateTime(2026, 1, 1);
  return db
      .into(db.coffees)
      .insert(
        CoffeesCompanion.insert(
          id: id,
          name: name,
          roaster: roaster,
          createdAt: now,
          updatedAt: now,
        ),
      );
}

Future<void> _insertEntry(
  AppDatabase db, {
  required String id,
  required String coffeeId,
  required DateTime brewAt,
}) {
  return db
      .into(db.entries)
      .insert(
        EntriesCompanion.insert(
          id: id,
          coffeeId: coffeeId,
          brewAt: brewAt,
          brewMethod: 'V60',
          coffeeDoseG: 18,
          waterTotalG: 300,
          brewTimeSecAuto: const Value(180),
          createdAt: brewAt.add(const Duration(hours: 6)),
          updatedAt: brewAt.add(const Duration(hours: 6)),
        ),
      );
}
