import 'package:coffee_journal/core/models/recipe_step_draft.dart';

class BrewTimeCalculator {
  const BrewTimeCalculator();

  int calculateAutoBrewTimeSec(List<RecipeStepDraft> steps) {
    if (steps.isEmpty) return 0;

    var maxTimeline = 0;
    var cumulative = 0;

    for (final step in steps) {
      final duration = step.durationSec ?? 0;
      final start = step.startSec;
      if (start != null) {
        final end = start + duration;
        if (end > maxTimeline) {
          maxTimeline = end;
        }
      }
      cumulative += duration;
    }

    return maxTimeline > 0 ? maxTimeline : cumulative;
  }
}
