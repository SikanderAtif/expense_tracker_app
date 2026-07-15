// ignore_for_file: deprecated_member_use

import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/models/transaction_type.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  final Expense expense;
  final void Function(Expense, bool) _openAddTransactionScreen;

  const TransactionItem({
    super.key,
    required this.expense,
    required this._openAddTransactionScreen,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme color = Theme.of(context).colorScheme;

    return Column(
      children: [
        ListTile(
          onTap: () {_openAddTransactionScreen(expense, true);},
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          tileColor: color.secondary.withOpacity(0.1),
          leading: Icon(
            expense.category.icon,
            color: expense.category.color,
          ),
          title: Text(
            expense.text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: color.primary, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            DateFormat(expense.timestamp.hour == 0 ? "MMM dd" : 'MMM dd . HH:mm').format(expense.timestamp),
            style: TextStyle(color: color.secondary),
          ),
          trailing: expense.type.label == TType.expense.label
              ? Text(
                  '-PKR ${expense.amount}',
                  style: TextStyle(color: Colors.red.shade700),
                )
              : Text(
                  '+PKR ${expense.amount}',
                  style: TextStyle(color: Colors.green.shade700),
                ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
