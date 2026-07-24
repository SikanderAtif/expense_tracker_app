// ignore_for_file: deprecated_member_use

import 'package:expense_tracker_app/l10n/app_localizations.dart';
import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/widgets/transaction_item.dart';
import 'package:flutter/material.dart';

class LatestTransactions extends StatelessWidget {
  final void Function() _openTransactionsScreen;
  final void Function(Expense, bool) _openAddTransactionScreen;
  final List<Expense> expenses;

  const LatestTransactions({
    super.key,
    required this._openTransactionsScreen,
    required this._openAddTransactionScreen,
    required this.expenses,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme color = Theme.of(context).colorScheme;
    final locale = AppLocalizations.of(context)!;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              locale.transactions,
              style: TextStyle(
                color: color.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: _openTransactionsScreen,
              child: Text(locale.viewAll, style: TextStyle(color: color.onSurface)),
            ),
          ],
        ),
        SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: expenses.length,
          itemBuilder: (BuildContext context, int index) {
            return TransactionItem(expense: expenses[index], openAddTransactionScreen: _openAddTransactionScreen);
          },
        ),
      ],
    );
  }
}
