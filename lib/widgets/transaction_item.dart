// ignore_for_file: deprecated_member_use

import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/models/transaction_type.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  final List<Expense> expenses;
  final int index;

  const TransactionItem({
    super.key,
    required this.expenses,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme color = Theme.of(context).colorScheme;

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
            style: TextStyle(color: color.primary, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            DateFormat(expenses[index].timestamp.hour == 0 ? "MMM dd" : 'MMM dd . HH:mm').format(expenses[index].timestamp),
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
  }
}
