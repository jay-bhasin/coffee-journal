import 'package:coffee_journal/core/models/enums.dart';

class UnitConverter {
  const UnitConverter();

  static const double _gramsPerOunce = 28.3495;

  double gramsToOunces(double grams) => grams / _gramsPerOunce;

  double ouncesToGrams(double ounces) => ounces * _gramsPerOunce;

  double cToF(double celsius) => (celsius * 9 / 5) + 32;

  double fToC(double fahrenheit) => (fahrenheit - 32) * 5 / 9;

  String waterLabel(UnitSystem unitSystem) => unitSystem == UnitSystem.metric ? 'g' : 'oz';

  String tempLabel(UnitSystem unitSystem) => unitSystem == UnitSystem.metric ? 'C' : 'F';
}
