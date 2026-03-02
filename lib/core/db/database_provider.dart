import 'package:coffee_journal/core/db/database.dart';
import 'package:coffee_journal/core/repositories/contracts.dart';
import 'package:coffee_journal/core/repositories/local_repositories.dart';
import 'package:coffee_journal/core/search/search_indexer.dart';
import 'package:coffee_journal/core/utils/brew_time_calculator.dart';
import 'package:coffee_journal/core/utils/recipe_scaler.dart';
import 'package:coffee_journal/core/utils/unit_converter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final searchIndexerProvider = Provider((ref) => const SearchIndexer());
final recipeScalerProvider = Provider((ref) => const RecipeScaler());
final brewTimeCalculatorProvider = Provider((ref) => const BrewTimeCalculator());
final unitConverterProvider = Provider((ref) => const UnitConverter());

final coffeeRepositoryProvider = Provider<CoffeeRepository>((ref) {
  return LocalCoffeeRepository(
    ref.watch(appDatabaseProvider),
    ref.watch(searchIndexerProvider),
  );
});

final entryRepositoryProvider = Provider<EntryRepository>((ref) {
  return LocalEntryRepository(
    ref.watch(appDatabaseProvider),
    ref.watch(searchIndexerProvider),
  );
});

final templateRepositoryProvider = Provider<TemplateRepository>((ref) {
  return LocalTemplateRepository(
    ref.watch(appDatabaseProvider),
    ref.watch(searchIndexerProvider),
  );
});

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return LocalSettingsRepository(ref.watch(appDatabaseProvider));
});

final backupRepositoryProvider = Provider<BackupRepository>((ref) {
  return LocalBackupRepository(ref.watch(appDatabaseProvider));
});

final unitSystemProvider = FutureProvider((ref) {
  return ref.watch(settingsRepositoryProvider).getUnitSystem();
});
