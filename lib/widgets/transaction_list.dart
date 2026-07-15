import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/widgets/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Expense> _expenses;
  final void Function(Expense, bool) _openAddTransactionScreen;

  const TransactionList({super.key, required this._expenses, required this._openAddTransactionScreen});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: ListView.builder(
        itemCount: _expenses.length,
        itemBuilder: (BuildContext context, int index) {
          String formattedDate = DateFormat(
            'MMM dd, y',
          ).format(_expenses[index].timestamp);
          DateTime now = DateTime.now();
          DateTime itemDate = _expenses[index].timestamp;
          DateTime yesterday = now.subtract(Duration(days: 1));
          bool isToday =
              now.year == itemDate.year &&
              now.month == itemDate.month &&
              now.day == itemDate.day;
          bool isYesterday =
              yesterday.year == itemDate.year &&
              yesterday.month == itemDate.month &&
              yesterday.day == itemDate.day;
          String today = 'TODAY';
          String yest = 'YESTERDAY';

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (index == 0 ||
                      _expenses[index].timestamp.day !=
                          _expenses[index - 1].timestamp.day)
                  ? Column(
                      children: [
                        SizedBox(height: 16),
                        Text(
                          isToday
                              ? today
                              : isYesterday
                              ? yest
                              : formattedDate,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    )
                  : SizedBox(height: 1),
              TransactionItem(expense: _expenses[index], openAddTransactionScreen: _openAddTransactionScreen),
            ],
          );
        },
      ),
    );
  }
}
