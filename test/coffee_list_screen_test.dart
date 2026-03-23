import 'package:coffee_journal/core/db/database.dart';
import 'package:coffee_journal/core/db/database_provider.dart';
import 'package:coffee_journal/core/repositories/local_repositories.dart';
import 'package:coffee_journal/core/search/search_indexer.dart';
import 'package:coffee_journal/features/coffees/coffee_list_screen.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  testWidgets(
    'coffee list shows last entry date and recent activity sort label',
    (tester) async {
      final latestBrew = DateTime(2026, 3, 22, 7, 45);
      await _insertCoffee(db, id: 'coffee-1', name: 'Kenya AA');
      await _insertEntry(
        db,
        id: 'entry-1',
        coffeeId: 'coffee-1',
        brewAt: latestBrew,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            coffeeRepositoryProvider.overrideWithValue(
              LocalCoffeeRepository(db, const SearchIndexer()),
            ),
          ],
          child: const MaterialApp(home: CoffeeListScreen()),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Recent activity'), findsOneWidget);
      expect(find.text('Last entry Mar 22, 2026'), findsOneWidget);
    },
  );
}

Future<void> _insertCoffee(
  AppDatabase db, {
  required String id,
  required String name,
}) {
  final now = DateTime(2026, 1, 1);
  return db
      .into(db.coffees)
      .insert(
        CoffeesCompanion.insert(
          id: id,
          name: name,
          roaster: 'Roaster',
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
          createdAt: brewAt,
          updatedAt: brewAt,
        ),
      );
}
