import 'package:coffee_journal/core/db/database.dart';
import 'package:coffee_journal/core/models/enums.dart';
import 'package:coffee_journal/core/models/recipe_step_draft.dart';

class CoffeeRecord {
  const CoffeeRecord({
    required this.coffee,
    required this.tags,
    this.lastEntryAt,
  });

  final Coffee coffee;
  final List<String> tags;
  final DateTime? lastEntryAt;
}

class EntryRecord {
  const EntryRecord({
    required this.entry,
    required this.steps,
  });

  final Entry entry;
  final List<EntryStep> steps;
}

class TemplateRecord {
  const TemplateRecord({
    required this.template,
    required this.steps,
    required this.tags,
  });

  final Template template;
  final List<TemplateStep> steps;
  final List<String> tags;
}

class EntryFilter {
  const EntryFilter({
    this.method,
    this.starredOnly = false,
    this.start,
    this.end,
  });

  final String? method;
  final bool starredOnly;
  final DateTime? start;
  final DateTime? end;
}

abstract class CoffeeRepository {
  Future<List<CoffeeRecord>> list({
    String query,
    CoffeeSortOption sort,
    bool? isArchived,
  });

  Future<CoffeeRecord?> getById(String id);

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
    String? altitudeM,
    DateTime? roastDate,
    String? tastingNotes,
    String? notes,
    List<String> tags,
    bool isArchived,
  });

  Future<void> delete(String id);
}

abstract class EntryRepository {
  Future<List<EntryRecord>> listForCoffee(
    String coffeeId, {
    EntrySortOption sort,
    EntryFilter filter,
  });

  Future<EntryRecord?> getById(String id);

  Future<void> upsert({
    String? id,
    required String coffeeId,
    required DateTime brewAt,
    required String brewMethod,
    required bool isStarred,
    required double coffeeDoseG,
    required double waterTotalG,
    double? waterTempC,
    String? waterCondition,
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
  });

  Future<void> duplicateEntryToNewDay(String entryId, DateTime newDate);

  Future<void> delete(String id);
}

abstract class TemplateRepository {
  Future<List<TemplateRecord>> list({String? coffeeId});
  Future<TemplateRecord?> getById(String id);

  Future<void> upsert({
    String? id,
    required String name,
    required TemplateScope scope,
    String? coffeeId,
    required String brewMethod,
    double? defaultCoffeeDoseG,
    double? defaultWaterTotalG,
    required List<RecipeStepDraft> steps,
    List<String> tags,
  });

  Future<void> delete(String id);
}

abstract class BackupRepository {
  Future<Map<String, dynamic>> exportBundle();
  Future<ImportPreview> previewImport(Map<String, dynamic> payload);
  Future<void> importBundle(Map<String, dynamic> payload);
}

abstract class BrewMethodRepository {
  Future<List<BrewMethodOption>> list({bool includeInactive = false});
  Future<void> upsert({required String name, bool isActive, int? sortOrder});
  Future<void> delete(String name);
}

class BrewMethodOption {
  const BrewMethodOption({
    required this.name,
    required this.sortOrder,
    required this.isActive,
  });

  final String name;
  final int sortOrder;
  final bool isActive;
}

class ImportPreview {
  const ImportPreview({
    required this.coffeeCount,
    required this.entryCount,
    required this.templateCount,
    required this.tagCount,
    required this.conflictCount,
  });

  final int coffeeCount;
  final int entryCount;
  final int templateCount;
  final int tagCount;
  final int conflictCount;
}

abstract class SettingsRepository {
  Future<WeightUnitSystem> getWeightUnitSystem();
  Future<void> setWeightUnitSystem(WeightUnitSystem unitSystem);
  Future<TemperatureUnitSystem> getTemperatureUnitSystem();
  Future<void> setTemperatureUnitSystem(TemperatureUnitSystem unitSystem);
  Future<bool> getDarkModeEnabled();
  Future<void> setDarkModeEnabled(bool enabled);
}
