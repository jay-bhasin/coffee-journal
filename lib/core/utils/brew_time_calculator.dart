import 'package:coffee_journal/core/models/recipe_step_draft.dart';
import 'package:coffee_journal/core/utils/recipe_timeline.dart';

class BrewTimeCalculator {
  const BrewTimeCalculator();

  int calculateAutoBrewTimeSec(List<RecipeStepDraft> steps) {
    if (steps.isEmpty) return 0;

    final normalized = RecipeTimeline.normalize(steps);
    var maxTimeline = 0;

    for (final step in normalized) {
      final duration = step.durationSec ?? 0;
      final end = (step.startSec ?? 0) + duration;
      if (end > maxTimeline) {
        maxTimeline = end;
      }
    }

    return maxTimeline;
  }
}
