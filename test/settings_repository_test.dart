import 'package:coffee_journal/core/db/database.dart';
import 'package:coffee_journal/core/models/enums.dart';
import 'package:coffee_journal/core/repositories/local_repositories.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late LocalSettingsRepository repository;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repository = LocalSettingsRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  test('legacy unit_system seeds both split settings', () async {
    await db.upsertSetting('unit_system', UnitSystem.imperial.name);

    expect(
      await repository.getWeightUnitSystem(),
      WeightUnitSystem.ounces,
    );
    expect(
      await repository.getTemperatureUnitSystem(),
      TemperatureUnitSystem.fahrenheit,
    );
  });

  test('weight and temperature settings persist independently', () async {
    await repository.setWeightUnitSystem(WeightUnitSystem.ounces);
    await repository.setTemperatureUnitSystem(TemperatureUnitSystem.celsius);

    expect(
      await repository.getWeightUnitSystem(),
      WeightUnitSystem.ounces,
    );
    expect(
      await repository.getTemperatureUnitSystem(),
      TemperatureUnitSystem.celsius,
    );
  });
}
