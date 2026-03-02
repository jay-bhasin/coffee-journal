import 'package:json_annotation/json_annotation.dart';

part 'sensory_notes.g.dart';

@JsonSerializable()
class SensoryNotes {
  const SensoryNotes({
    this.aroma,
    this.flavor,
    this.acidity,
    this.sweetness,
    this.body,
    this.aftertaste,
    this.freeText,
  });

  final String? aroma;
  final String? flavor;
  final String? acidity;
  final String? sweetness;
  final String? body;
  final String? aftertaste;
  final String? freeText;

  factory SensoryNotes.fromJson(Map<String, dynamic> json) =>
      _$SensoryNotesFromJson(json);

  Map<String, dynamic> toJson() => _$SensoryNotesToJson(this);
}
