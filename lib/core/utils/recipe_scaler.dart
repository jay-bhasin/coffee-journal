import 'dart:math' as math;

import 'package:coffee_journal/core/models/recipe_step_draft.dart';

class RecipeScaler {
  const RecipeScaler();

  double computeRatio({required double coffeeDoseG, required double waterTotalG}) {
    if (coffeeDoseG <= 0) return 0;
    return waterTotalG / coffeeDoseG;
  }

  double counterpartForLockedRatio({
    required double changedValue,
    required bool changedCoffeeDose,
    required double ratio,
  }) {
    if (ratio <= 0) return changedValue;
    if (changedCoffeeDose) {
      return changedValue * ratio;
    }
    return changedValue / ratio;
  }

  List<RecipeStepDraft> redistributeWater(
    List<RecipeStepDraft> steps,
    double oldWaterTotalG,
    double newWaterTotalG,
  ) {
    if (steps.isEmpty) return steps;

    final indexed = <int>[];
    var sum = 0.0;
    for (var i = 0; i < steps.length; i++) {
      final water = steps[i].waterG;
      if (water != null) {
        indexed.add(i);
        sum += water;
      }
    }

    if (indexed.isEmpty) return steps;
    final target = math.max(0, newWaterTotalG);

    return [
      for (var i = 0; i < steps.length; i++)
        if (!indexed.contains(i))
          steps[i]
        else
          () {
            final current = steps[i].waterG ?? 0;
            final weight = sum <= 0 ? 1 / indexed.length : current / sum;
            return steps[i].copyWith(waterG: (target * weight));
          }(),
    ];
  }
}
