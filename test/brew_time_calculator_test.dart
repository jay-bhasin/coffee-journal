import 'package:coffee_journal/core/models/enums.dart';
import 'package:coffee_journal/core/models/recipe_step_draft.dart';
import 'package:coffee_journal/core/utils/brew_time_calculator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const calculator = BrewTimeCalculator();

  test('uses max timeline when start times exist', () {
    final steps = [
      RecipeStepDraft(type: RecipeStepType.bloom, index: 0, startSec: 0, durationSec: 30),
      RecipeStepDraft(type: RecipeStepType.pour, index: 1, startSec: 45, durationSec: 25),
    ];

    expect(calculator.calculateAutoBrewTimeSec(steps), 70);
  });

  test('falls back to cumulative duration', () {
    final steps = [
      RecipeStepDraft(type: RecipeStepType.wait, index: 0, durationSec: 20),
      RecipeStepDraft(type: RecipeStepType.wait, index: 1, durationSec: 35),
    ];

    expect(calculator.calculateAutoBrewTimeSec(steps), 55);
  });
}
