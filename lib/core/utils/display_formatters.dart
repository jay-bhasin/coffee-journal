import 'package:coffee_journal/core/models/enums.dart';
import 'package:coffee_journal/core/utils/unit_converter.dart';
import 'package:flutter/material.dart';

class DisplayFormatters {
  const DisplayFormatters._();

  static String formatDuration(int? seconds) {
    if (seconds == null) return '';
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString()}:${secs.toString().padLeft(2, '0')}'; // .padLeft(2, '0')
  }

  static String formatWeight(double? grams) {
    if (grams == null) return '';
    return '${grams.toStringAsFixed(1)} g';
  }

  static String? formatTemperature(
    double? celsius,
    UnitSystem unitSystem,
    UnitConverter unitConverter,
  ) {
    if (celsius == null) return null;
    if (unitSystem == UnitSystem.imperial) {
      return '${unitConverter.cToF(celsius).toStringAsFixed(0)} °F';
    }
    return '${celsius.toStringAsFixed(0)} °C';
  }

  static String? formatGrinder(String? grinder, String? grindSetting) {
    final g = grinder?.trim();
    final s = grindSetting?.trim();
    final hasG = g != null && g.isNotEmpty;
    final hasS = s != null && s.isNotEmpty;
    if (!hasG && !hasS) return null;
    if (hasG && hasS) return '$s ($g)';
    return hasS ? s : g;
  }

  static String formatExtractionOutcome(String value) {
    switch (value) {
      case 'under':
        return 'Under-extracted';
      case 'exact':
        return 'Good extraction';
      case 'over':
        return 'Over-extracted';
      default:
        return 'Unknown';
    }
  }

  static IconData extractionOutcomeIcon(String value) {
    switch(value) {
      case 'under':
      case 'over':
        return Icons.sentiment_dissatisfied_outlined;
      case 'exact':
        return Icons.sentiment_very_satisfied_outlined;
      default:
        return Icons.sentiment_neutral_outlined;
    }
  }

  static String formatPressure(double bar) => '${bar.toStringAsFixed(1)} bar';
}
