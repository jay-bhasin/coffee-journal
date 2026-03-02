import 'package:coffee_journal/core/models/enums.dart';

class RecipeStepDraft {
  RecipeStepDraft({
    required this.type,
    required this.index,
    this.startSec,
    this.durationSec,
    this.note,
    this.waterG,
    this.flowRateGPerSec,
    this.pressureBar,
    this.count,
    this.tool,
    this.label,
    this.jsonPayload,
  });

  final RecipeStepType type;
  final int index;
  final int? startSec;
  final int? durationSec;
  final String? note;
  final double? waterG;
  final double? flowRateGPerSec;
  final double? pressureBar;
  final int? count;
  final String? tool;
  final String? label;
  final String? jsonPayload;

  RecipeStepDraft copyWith({
    RecipeStepType? type,
    int? index,
    int? startSec,
    int? durationSec,
    String? note,
    double? waterG,
    double? flowRateGPerSec,
    double? pressureBar,
    int? count,
    String? tool,
    String? label,
    String? jsonPayload,
  }) {
    return RecipeStepDraft(
      type: type ?? this.type,
      index: index ?? this.index,
      startSec: startSec ?? this.startSec,
      durationSec: durationSec ?? this.durationSec,
      note: note ?? this.note,
      waterG: waterG ?? this.waterG,
      flowRateGPerSec: flowRateGPerSec ?? this.flowRateGPerSec,
      pressureBar: pressureBar ?? this.pressureBar,
      count: count ?? this.count,
      tool: tool ?? this.tool,
      label: label ?? this.label,
      jsonPayload: jsonPayload ?? this.jsonPayload,
    );
  }
}
