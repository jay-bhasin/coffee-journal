import 'package:coffee_journal/core/models/enums.dart';
import 'package:coffee_journal/core/models/recipe_step_draft.dart';
import 'package:coffee_journal/core/utils/recipe_timeline.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('normalizes indexes and derives cumulative start times', () {
    final normalized = RecipeTimeline.normalize([
      RecipeStepDraft(type: RecipeStepType.bloom, index: 4, startSec: 99, durationSec: 30),
      RecipeStepDraft(type: RecipeStepType.stir, index: 8, startSec: 5),
      RecipeStepDraft(type: RecipeStepType.wait, index: 1, startSec: 12, durationSec: 45),
    ]);

    expect(normalized.map((step) => step.index), [0, 1, 2]);
    expect(normalized.map((step) => step.startSec), [0, 30, 30]);
    expect(normalized.map((step) => step.durationSec), [30, isNull, 45]);
  });
}
