enum BrewMethod {
  v60('V60'),
  kalita('Kalita'),
  chemex('Chemex'),
  aeropress('Aeropress'),
  frenchPress('French Press'),
  espresso('Espresso'),
  moka('Moka'),
  other('Other');

  const BrewMethod(this.label);
  final String label;
}

enum RecipeStepType {
  bloom,
  pour,
  wait,
  stir,
  swirl,
  preinfuse,
  pull,
  custom,
}

enum ExtractionOutcome {
  under,
  slightUnder,
  exact,
  slightOver,
  over,
  unknown,
}

enum TemplateScope {
  global,
  coffee,
}

enum UnitSystem {
  metric,
  imperial,
}

enum WeightUnitSystem {
  grams,
  ounces,
}

enum TemperatureUnitSystem {
  celsius,
  fahrenheit,
}

enum CoffeeSortOption {
  name,
  roaster,
  country,
  roastDate,
  updatedAt,
}

enum EntrySortOption {
  starredNewest,
  newest,
  oldest,
  method,
}
