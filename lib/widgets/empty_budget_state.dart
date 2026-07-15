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

    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              _openSetBudgetScreen(budget);
            },
            child: Text(
              'Set Your Budget',
              style: TextStyle(color: color.primary),
            ),
          ),
        ),
      ],
    );
  }
}
