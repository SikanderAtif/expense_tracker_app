// ignore_for_file: deprecated_member_use

import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/models/transaction_type.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LatestTransactions extends StatelessWidget {
  final void Function() _openTransactionsScreen;
  final List<Expense> expenses;

  const LatestTransactions({
    super.key,
    required this._openTransactionsScreen,
    required this.expenses,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme color = Theme.of(context).colorScheme;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Transactions',
              style: TextStyle(
                color: color.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: _openTransactionsScreen,
              child: Text('View All', style: TextStyle(color: color.onSurface)),
            ),
          ],
        ),
        SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: expenses.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  tileColor: color.secondary.withOpacity(0.1),
                  leading: Icon(
                    expenses[index].category.icon,
                    color: expenses[index].category.color,
                  ),
                  title: Text(
                    expenses[index].text,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: color.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    DateFormat('MMM d . H:m').format(expenses[index].timestamp),
                    style: TextStyle(color: color.secondary),
                  ),
                  trailing: expenses[index].type.label == TType.expense.label
                      ? Text(
                          '-PKR ${expenses[index].amount}',
                          style: TextStyle(color: Colors.red.shade700),
                        )
                      : Text(
                          '+PKR ${expenses[index].amount}',
                          style: TextStyle(color: Colors.green.shade700),
                        ),
                ),
                SizedBox(height: 16),
              ],
            );
          },
        ),
      ],
    );
  }
}
