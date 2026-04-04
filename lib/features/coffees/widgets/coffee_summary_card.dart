import 'package:coffee_journal/core/repositories/contracts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CoffeeSummaryCard extends StatefulWidget {
  const CoffeeSummaryCard({
    super.key,
    required this.record,
    this.margin = const EdgeInsets.fromLTRB(12, 12, 12, 0),
    this.showDetails = true,
  });

  final CoffeeRecord record;
  final EdgeInsetsGeometry margin;
  final bool showDetails;

  @override
  State<CoffeeSummaryCard> createState() => _CoffeeSummaryCardState();
}

class _CoffeeSummaryCardState extends State<CoffeeSummaryCard> {
  bool _showNotes = false;

  @override
  Widget build(BuildContext context) {
    final coffee = widget.record.coffee;
    final location = _formatLocation(coffee.region, coffee.country);
    final metaChips = <String>[
      if (!_isBlank(location)) location!,
      if (!_isBlank(coffee.varietal)) coffee.varietal!,
      if (!_isBlank(coffee.process)) coffee.process!,
    ];
    final primaryDetailLine = <String>[
      if (!_isBlank(coffee.farm)) 'Farm: ${coffee.farm!}',
      if (!_isBlank(coffee.producer)) 'Producer: ${coffee.producer!}',
      if (!_isBlank(coffee.altitudeM)) 'Altitude: ${coffee.altitudeM!}',
    ].join(' • ');
    final secondaryDetailLine = <String>[
      if (coffee.roastDate != null) 'Roasted ${DateFormat.yMMMd().format(coffee.roastDate!)}',
      if (widget.record.tags.isNotEmpty) 'Tags: ${widget.record.tags.join(', ')}',
    ].join(' • ');
    final hasNotes = !_isBlank(coffee.notes);

    return Container(
      margin: widget.margin,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      coffee.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      coffee.roaster,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              if (widget.showDetails && hasNotes)
                IconButton(
                  tooltip: _showNotes ? 'Hide coffee notes' : 'Show coffee notes',
                  onPressed: () => setState(() => _showNotes = !_showNotes),
                  icon: Icon(
                    _showNotes ? Icons.sticky_note_2 : Icons.sticky_note_2_outlined,
                  ),
                ),
            ],
          ),
          if (widget.showDetails) ...[
            if (metaChips.isNotEmpty) ...[
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: metaChips
                    .map(
                      (value) => Chip(
                        visualDensity: VisualDensity.compact,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        labelPadding: const EdgeInsets.symmetric(horizontal: 6),
                        label: Text(value),
                      ),
                    )
                    .toList(growable: false),
              ),
            ],
            if (_showNotes && hasNotes) ...[
              const SizedBox(height: 8),
              AnimatedSize(
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeOut,
                child: Text(
                  coffee.notes!,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
            if (!_isBlank(coffee.tastingNotes)) ...[
              const SizedBox(height: 8),
              Text(
                coffee.tastingNotes!,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
            if (primaryDetailLine.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                primaryDetailLine,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
            if (secondaryDetailLine.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                secondaryDetailLine,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ],
        ],
      ),
    );
  }

  String? _formatLocation(String? region, String? country) {
    final r = region?.trim();
    final c = country?.trim();
    final hasR = r != null && r.isNotEmpty;
    final hasC = c != null && c.isNotEmpty;
    if (!hasR && !hasC) return null;
    if (hasR && hasC) return '$r, $c';
    return hasR ? r : c;
  }

  bool _isBlank(String? value) => value == null || value.trim().isEmpty;
}
