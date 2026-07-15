import 'package:expense_tracker_app/models/category.dart';
import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/models/period.dart';
import 'package:expense_tracker_app/services/expense_helper.dart';
import 'package:expense_tracker_app/utils/date_time_extension.dart';
import 'package:expense_tracker_app/widgets/spending_flow.dart';
import 'package:expense_tracker_app/widgets/top_categories.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  Period _selectedPeriod = Period.week;
  late List<Expense> _data;
  late Future<List<dynamic>> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = _initData();
  }

  Future<List<dynamic>> _initData() async {
    final List<String> labels = [];
    final List<Category> cLabels = [];
    final List<double> sum = [];
    final List<double> sumCategories = [];

    DateTime start = DateTime.now();
    DateTime end = DateTime.now();

    if (_selectedPeriod == Period.week) {
      start = DateTime.now().currentWeekRange.start;
      end = DateTime.now().currentWeekRange.end;
    } else if (_selectedPeriod == Period.month) {
      start = DateTime.now().currentMonthRange.start;
      end = DateTime.now().currentMonthRange.end;
    } else if (_selectedPeriod == Period.year) {
      start = DateTime.now().currentYearRange.start;
      end = DateTime.now().currentYearRange.end;
    }

    _data = await ExpensesHelper.getSpendingFlow(start, end);

    for (var c in Category.values) {
      double amount = await ExpensesHelper.getExpenseAmountFor(
        c.label,
        start,
        end,
      );
      sumCategories.add(amount);
      cLabels.add(c);
    }

    for (int index = 0; index < _data.length; index++) {
      if (_selectedPeriod != Period.week && sum.length > 7) {
        sum.removeAt(7);
        break;
      }

      bool isSameGrouping = false;
      if (index != 0) {
        if (_selectedPeriod == Period.year) {
          isSameGrouping =
              _data[index].timestamp.month == _data[index - 1].timestamp.month;
        } else {
          isSameGrouping =
              _data[index].timestamp.day == _data[index - 1].timestamp.day;
        }
      }

      if (isSameGrouping) {
        sum.last += _data[index].amount;
        continue;
      }

      sum.add(_data[index].amount);

      String label = '';
      if (_selectedPeriod == Period.week) {
        label = DateFormat('EEE').format(_data[index].timestamp);
      } else if (_selectedPeriod == Period.month) {
        label = DateFormat('dd/MMM').format(_data[index].timestamp);
      } else if (_selectedPeriod == Period.year) {
        label = DateFormat('MMM').format(_data[index].timestamp);
      }
      labels.add(label);
    }

    return [
      sum.reversed.toList(),
      labels.reversed.toList(),
      sumCategories,
      cLabels,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme color = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text('Statistics')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: SegmentedButton<Period>(
                      showSelectedIcon: false,
                      selected: <Period>{_selectedPeriod},
                      onSelectionChanged: (Set<Period> newSelection) {
                        setState(() {
                          _selectedPeriod = newSelection.first;
                          _dataFuture = _initData();
                        });
                      },
                      segments: [
                        ButtonSegment<Period>(
                          value: Period.week,
                          label: Text(Period.week.label),
                        ),
                        ButtonSegment<Period>(
                          value: Period.month,
                          label: Text(Period.month.label),
                        ),
                        ButtonSegment<Period>(
                          value: Period.year,
                          label: Text(Period.year.label),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              FutureBuilder<List<dynamic>>(
                future: _dataFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error Retrieving Data'));
                  }
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return snapshot.data![0].length == 0
                      ? Center(
                          child: Text(
                            'No Data Yet',
                            style: TextStyle(color: color.primary),
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SpendingFlow(
                              chartData: snapshot.data![0],
                              labels: snapshot.data![1],
                            ),
                            SizedBox(height: 24),
                            Text(
                              'Top Categories',
                              style: TextStyle(
                                color: color.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 12),
                            TopCategories(
                              sumList: snapshot.data![2],
                              labels: snapshot.data![3],
                            ),
                          ],
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
