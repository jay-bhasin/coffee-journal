import 'package:coffee_journal/core/models/enums.dart';
import 'package:coffee_journal/core/utils/display_formatters.dart';
import 'package:coffee_journal/core/utils/unit_converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const converter = UnitConverter();

  test('metric formatter uses grams and celsius', () {
    const formatter = AppDisplayFormatter(
      weightUnitSystem: WeightUnitSystem.grams,
      temperatureUnitSystem: TemperatureUnitSystem.celsius,
      unitConverter: converter,
    );

    expect(formatter.formatWeight(18), '18.0 g');
    expect(formatter.formatTemperature(93), '93 °C');
  });

  test('imperial formatter uses ounces and fahrenheit', () {
    const formatter = AppDisplayFormatter(
      weightUnitSystem: WeightUnitSystem.ounces,
      temperatureUnitSystem: TemperatureUnitSystem.fahrenheit,
      unitConverter: converter,
    );

    expect(formatter.formatWeight(18), '0.63 oz');
    expect(formatter.formatTemperature(93), '199 °F');
  });

  test('formatter supports mixed unit preferences', () {
    const formatter = AppDisplayFormatter(
      weightUnitSystem: WeightUnitSystem.grams,
      temperatureUnitSystem: TemperatureUnitSystem.fahrenheit,
      unitConverter: converter,
    );

    expect(formatter.formatWeight(18), '18.0 g');
    expect(formatter.formatTemperature(93), '199 °F');
  });

  test('formatter handles null values', () {
    const formatter = AppDisplayFormatter(
      weightUnitSystem: WeightUnitSystem.ounces,
      temperatureUnitSystem: TemperatureUnitSystem.celsius,
      unitConverter: converter,
    );

    expect(formatter.formatWeight(null), '');
    expect(formatter.formatTemperature(null), isNull);
  });
}
