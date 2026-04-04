import 'package:coffee_journal/core/db/database.dart';
import 'package:coffee_journal/core/models/enums.dart';
import 'package:coffee_journal/core/models/recipe_step_draft.dart';
import 'package:coffee_journal/core/repositories/contracts.dart';
import 'package:coffee_journal/core/utils/recipe_timeline.dart';

class EntryActions {
  const EntryActions._();

  static Future<void> toggleStar(
    EntryRepository repository,
    EntryRecord record,
  ) {
    final entry = record.entry;
    return repository.upsert(
      id: entry.id,
      coffeeId: entry.coffeeId,
      brewAt: entry.brewAt,
      brewMethod: entry.brewMethod,
      isStarred: !entry.isStarred,
      coffeeDoseG: entry.coffeeDoseG,
      waterTotalG: entry.waterTotalG,
      waterTempC: entry.waterTempC,
      grinder: entry.grinder,
      grindSetting: entry.grindSetting,
      yieldG: entry.yieldG,
      pressureBar: entry.pressureBar,
      preinfusionSec: entry.preinfusionSec,
      brewTimeSecAuto: entry.brewTimeSecAuto,
      brewTimeSecManual: entry.brewTimeSecManual,
      sensoryJson: entry.sensoryJson,
      dialInNotes: entry.dialInNotes,
      miscNotes: entry.miscNotes,
      agitationLevel: entry.agitationLevel,
      drawdownSec: entry.drawdownSec,
      extractionOutcome: ExtractionOutcome.values.firstWhere(
        (e) => e.name == entry.extractionOutcome,
        orElse: () => ExtractionOutcome.unknown,
      ),
      steps: stepDraftsFromSteps(record.steps),
    );
  }

  static Future<void> duplicateAsToday(
    EntryRepository repository,
    String entryId,
  ) {
    return repository.duplicateEntryToNewDay(entryId, DateTime.now());
  }

  static List<RecipeStepDraft> stepDraftsFromSteps(Iterable<EntryStep> steps) {
    return RecipeTimeline.normalize(
      steps.map(
        (s) => RecipeStepDraft(
          type: RecipeStepType.values.firstWhere(
            (e) => e.name == s.type,
            orElse: () => RecipeStepType.custom,
          ),
          index: s.stepIndex,
          startSec: s.startSec,
          durationSec: s.durationSec,
          note: s.note,
          waterG: s.waterG,
          flowRateGPerSec: s.flowRateGPerSec,
          pressureBar: s.pressureBar,
          count: s.count,
          tool: s.tool,
          label: s.label,
          jsonPayload: s.jsonPayload,
        ),
      ),
    );
  }
}
