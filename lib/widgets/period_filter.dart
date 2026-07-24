// ignore_for_file: deprecated_member_use

import 'package:expense_tracker_app/l10n/app_localizations.dart';
import 'package:expense_tracker_app/models/period.dart';
import 'package:flutter/material.dart';

class PeriodFilter extends StatelessWidget {
  final void Function(Period) _setPeriod;
  final Period _selectedPeriod;
  const PeriodFilter ({super.key, required this._setPeriod, required this._selectedPeriod});

  @override
  Widget build(BuildContext context) {
    final ColorScheme color = Theme.of(context).colorScheme;
    final locale = AppLocalizations.of(context)!;
    
    return Row(
      children: Period.values.map((p) {
        final isSelected = _selectedPeriod == p;

        return Padding(
          padding: EdgeInsets.all(12),
          child: FilterChip(
            showCheckmark: false,
            label: Text(
              switch(p) {
                Period.week => locale.periodWeek,
                Period.month => locale.periodMonth,
                Period.year => locale.periodYear,
              },
              style: TextStyle(
                color: isSelected ? color.primary : color.secondary,
              ),
            ),
            backgroundColor: color.secondary.withOpacity(0.1),
            selectedColor: color.onSurface,
            selected: isSelected,
            side: BorderSide(color: isSelected ? color.onSurface : color.secondary),
            onSelected: (_) => _setPeriod(p),
          ),
        );
      }).toList(),
    );
  }
}