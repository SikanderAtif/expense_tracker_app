// ignore_for_file: deprecated_member_use

import 'package:expense_tracker_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class MonthlyBudgetCard extends StatelessWidget {
  final double _budget;
  final double _spent;
  final double _remaining;

  const MonthlyBudgetCard({
    super.key,
    required this._budget,
    required this._spent,
    required this._remaining,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme color = Theme.of(context).colorScheme;
    final locale = AppLocalizations.of(context)!;

    return Container(
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: color.secondary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(
              locale.totalMonthlyBudget,
              style: TextStyle(color: color.secondary, fontSize: 10),
            ),
            subtitle: Text(
              '${locale.currency} $_budget',
              style: TextStyle(
                color: color.primary,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                CircularProgressIndicator(
                  strokeWidth: 6,
                  color: color.onSurface,
                  backgroundColor: color.secondary.withOpacity(0.2),
                  constraints: BoxConstraints(
                    minHeight: 62,
                    minWidth: 62,
                  ),
                  value: _spent / _budget,
                ),
                Text('${(_spent / _budget * 100).toStringAsFixed(2)}%', style: TextStyle(color: color.primary, fontSize: 10, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    locale.spent,
                    style: TextStyle(color: color.secondary, fontSize: 10),
                  ),
                  Text(
                    '${locale.currency} $_spent',
                    style: TextStyle(
                      color: Colors.red.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    locale.left,
                    style: TextStyle(color: color.secondary, fontSize: 10),
                  ),
                  Text(
                    '${locale.currency} $_remaining',
                    style: TextStyle(
                      color: Colors.green.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
