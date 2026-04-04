import 'package:coffee_journal/core/models/recipe_step_draft.dart';

class RecipeTimeline {
  const RecipeTimeline._();

  static List<RecipeStepDraft> normalize(Iterable<RecipeStepDraft> steps) {
    var cumulativeStart = 0;
    final normalized = <RecipeStepDraft>[];

    for (final entry in steps.toList(growable: false).asMap().entries) {
      final step = entry.value;
      normalized.add(
        RecipeStepDraft(
          type: step.type,
          index: entry.key,
          startSec: cumulativeStart,
          durationSec: step.durationSec,
          note: step.note,
          waterG: step.waterG,
          flowRateGPerSec: step.flowRateGPerSec,
          pressureBar: step.pressureBar,
          count: step.count,
          tool: step.tool,
          label: step.label,
          jsonPayload: step.jsonPayload,
        ),
      );
      cumulativeStart += step.durationSec ?? 0;
    }

    return normalized;
  }
}
