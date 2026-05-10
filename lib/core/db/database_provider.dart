import 'package:coffee_journal/core/db/database.dart';
import 'package:coffee_journal/core/models/enums.dart';
import 'package:coffee_journal/core/repositories/contracts.dart';
import 'package:coffee_journal/core/repositories/local_repositories.dart';
import 'package:coffee_journal/core/search/search_indexer.dart';
import 'package:coffee_journal/core/utils/brew_time_calculator.dart';
import 'package:coffee_journal/core/utils/display_formatters.dart';
import 'package:coffee_journal/core/utils/recipe_scaler.dart';
import 'package:coffee_journal/core/utils/unit_converter.dart';
import 'package:flutter/material.dart';
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

final brewMethodRepositoryProvider = Provider<BrewMethodRepository>((ref) {
  return LocalBrewMethodRepository(ref.watch(appDatabaseProvider));
});

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return LocalSettingsRepository(ref.watch(appDatabaseProvider));
});

final backupRepositoryProvider = Provider<BackupRepository>((ref) {
  return LocalBackupRepository(ref.watch(appDatabaseProvider));
});

final weightUnitSystemProvider = FutureProvider((ref) {
  return ref.watch(settingsRepositoryProvider).getWeightUnitSystem();
});

final temperatureUnitSystemProvider = FutureProvider((ref) {
  return ref.watch(settingsRepositoryProvider).getTemperatureUnitSystem();
});

final appDisplayFormatterProvider = Provider<AppDisplayFormatter>((ref) {
  final weightUnitSystem = ref.watch(weightUnitSystemProvider).maybeWhen(
        data: (value) => value,
        orElse: () => WeightUnitSystem.grams,
      );
  final temperatureUnitSystem = ref.watch(temperatureUnitSystemProvider).maybeWhen(
        data: (value) => value,
        orElse: () => TemperatureUnitSystem.celsius,
      );
  final unitConverter = ref.watch(unitConverterProvider);
  return AppDisplayFormatter(
    weightUnitSystem: weightUnitSystem,
    temperatureUnitSystem: temperatureUnitSystem,
    unitConverter: unitConverter,
  );
});

final themeModeProvider = NotifierProvider<ThemeModeController, ThemeMode>(
  ThemeModeController.new,
);

final appDataRevisionProvider = NotifierProvider<AppDataRevisionController, int>(
  AppDataRevisionController.new,
);

class ThemeModeController extends Notifier<ThemeMode> {
  bool _initialized = false;

  @override
  ThemeMode build() {
    if (!_initialized) {
      _initialized = true;
      _load();
    }
    return ThemeMode.light;
  }

  SettingsRepository get _settingsRepository => ref.read(settingsRepositoryProvider);

  Future<void> _load() async {
    final darkEnabled = await _settingsRepository.getDarkModeEnabled();
    state = darkEnabled ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> setDarkModeEnabled(bool enabled) async {
    state = enabled ? ThemeMode.dark : ThemeMode.light;
    await _settingsRepository.setDarkModeEnabled(enabled);
  }
}

class AppDataRevisionController extends Notifier<int> {
  @override
  int build() => 0;

  void bump() {
    state++;
  }
}
