import 'package:coffee_journal/core/models/enums.dart';
import 'package:coffee_journal/core/utils/unit_converter.dart';
import 'package:flutter/material.dart';

class AppDisplayFormatter {
  const AppDisplayFormatter({
    required this.weightUnitSystem,
    required this.temperatureUnitSystem,
    required this.unitConverter,
  });

  final WeightUnitSystem weightUnitSystem;
  final TemperatureUnitSystem temperatureUnitSystem;
  final UnitConverter unitConverter;

  String formatWeight(double? grams) {
    if (grams == null) return '';
    if (weightUnitSystem == WeightUnitSystem.ounces) {
      return '${unitConverter.gramsToOunces(grams).toStringAsFixed(2)} oz';
    }
    return '${grams.toStringAsFixed(1)} g';
  }

  String? formatTemperature(double? celsius) {
    if (celsius == null) return null;
    if (temperatureUnitSystem == TemperatureUnitSystem.fahrenheit) {
      return '${unitConverter.cToF(celsius).toStringAsFixed(0)} °F';
    }
    return '${celsius.toStringAsFixed(0)} °C';
  }
}

class DisplayFormatters {
  const DisplayFormatters._();

  static String formatDuration(int? seconds) {
    if (seconds == null) return '';
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString()}:${secs.toString().padLeft(2, '0')}'; // .padLeft(2, '0')
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
      case 'slightUnder':
        return 'Slightly under-extracted';
      case 'exact':
        return 'Good extraction';
      case 'slightOver':
        return 'Slightly over-extracted';
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
        return Icons.sentiment_very_dissatisfied_outlined;
      case 'slightUnder':
      case 'slightOver':
        return Icons.sentiment_dissatisfied_outlined;
      case 'exact':
        return Icons.sentiment_very_satisfied_outlined;
      default:
        return Icons.sentiment_neutral_outlined;
    }
  }

  static Widget extractionOutcomeOption(String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(extractionOutcomeIcon(value), size: 18),
        const SizedBox(width: 8),
        Flexible(child: Text(formatExtractionOutcome(value))),
      ],
    );
  }

  static String formatPressure(double bar) => '${bar.toStringAsFixed(1)} bar';
}
