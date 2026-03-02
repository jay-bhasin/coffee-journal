import 'package:coffee_journal/core/utils/unit_converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const converter = UnitConverter();

  test('grams and ounces roundtrip', () {
    final oz = converter.gramsToOunces(100);
    final grams = converter.ouncesToGrams(oz);
    expect(grams, closeTo(100, 0.001));
  });

  test('celsius and fahrenheit roundtrip', () {
    final f = converter.cToF(93);
    final c = converter.fToC(f);
    expect(c, closeTo(93, 0.001));
  });
}
