// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sensory_notes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SensoryNotes _$SensoryNotesFromJson(Map<String, dynamic> json) => SensoryNotes(
  aroma: json['aroma'] as String?,
  flavor: json['flavor'] as String?,
  acidity: json['acidity'] as String?,
  sweetness: json['sweetness'] as String?,
  body: json['body'] as String?,
  aftertaste: json['aftertaste'] as String?,
  freeText: json['freeText'] as String?,
);

Map<String, dynamic> _$SensoryNotesToJson(SensoryNotes instance) =>
    <String, dynamic>{
      'aroma': instance.aroma,
      'flavor': instance.flavor,
      'acidity': instance.acidity,
      'sweetness': instance.sweetness,
      'body': instance.body,
      'aftertaste': instance.aftertaste,
      'freeText': instance.freeText,
    };
