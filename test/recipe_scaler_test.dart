import 'package:coffee_journal/core/models/recipe_step_draft.dart';
import 'package:coffee_journal/core/models/enums.dart';
import 'package:coffee_journal/core/utils/recipe_scaler.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const scaler = RecipeScaler();

  test('compute ratio', () {
    final ratio = scaler.computeRatio(coffeeDoseG: 20, waterTotalG: 320);
    expect(ratio, 16);
  });

  test('redistribute water proportionally', () {
    final steps = [
      RecipeStepDraft(type: RecipeStepType.bloom, index: 0, waterG: 60),
      RecipeStepDraft(type: RecipeStepType.pour, index: 1, waterG: 240),
      RecipeStepDraft(type: RecipeStepType.wait, index: 2),
    ];

    final updated = scaler.redistributeWater(steps, 300, 360);

    expect(updated[0].waterG, closeTo(72, 0.001));
    expect(updated[1].waterG, closeTo(288, 0.001));
    expect(updated[2].waterG, isNull);
  });
}
