import 'package:expense_tracker_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class EmptyBudgetState extends StatelessWidget {
  final void Function(double, {bool update}) _openSetBudgetScreen;
  final double budget;

  const EmptyBudgetState({
    super.key,
    required this._openSetBudgetScreen,
    required this.budget,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme color = Theme.of(context).colorScheme;
    final locale = AppLocalizations.of(context)!;

    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              _openSetBudgetScreen(budget);
            },
            child: Text(
              locale.setYourBudget,
              style: TextStyle(color: color.primary),
            ),
          ),
        ),
      ],
    );
  }
}
