import 'package:expense_tracker_app/l10n/app_localizations.dart';
import 'package:expense_tracker_app/models/category.dart';
import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/models/period.dart';
import 'package:expense_tracker_app/screens/add_transaction.dart';
import 'package:expense_tracker_app/screens/transactions_screen.dart';
import 'package:expense_tracker_app/services/expense_helper.dart';
import 'package:expense_tracker_app/utils/date_time_extension.dart';
import 'package:expense_tracker_app/widgets/latest_transactions.dart';
import 'package:expense_tracker_app/widgets/period_filter.dart';
import 'package:expense_tracker_app/widgets/summary_card.dart';
import 'package:expense_tracker_app/widgets/spending_summary.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  Period _selectedPeriod = Period.week;
  DateTime start = DateTime.now().currentWeekRange.start;
  DateTime end = DateTime.now().currentWeekRange.end;
  late Future<List<dynamic>> _expenseFuture;
  late Future<List<dynamic>> _balanceFuture;

  @override
  void initState() {
    super.initState();
    _balanceFuture = _initBalance();
    _expenseFuture = _initExpense();
  }

  void _refreshData() {
    setState(() {
      _balanceFuture = _initBalance();
      _expenseFuture = _initExpense();
    });
  }

  void _setPeriod(Period p) {
    setState(() {
      if (p == Period.week) {
        start = DateTime.now().currentWeekRange.start;
        end = DateTime.now().currentWeekRange.end;
      }
      if (p == Period.month) {
        start = DateTime.now().currentMonthRange.start;
        end = DateTime.now().currentMonthRange.end;
      }
      if (p == Period.year) {
        start = DateTime.now().currentYearRange.start;
        end = DateTime.now().currentYearRange.end;
      }

      _selectedPeriod = p;
      _balanceFuture = _initBalance();
      _expenseFuture = _initExpense();
    });
  }

  void _openAddTransactionScreen(Expense? expense, bool update) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddTransactionScreen(expense: expense, update: update)),
    );

    _refreshData();
  }

  void _openTransactionsScreen() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TransactionsScreen()),
    );

    _refreshData();
  }

  Future<List<dynamic>> _initBalance() async {
    double income = await ExpensesHelper.income();
    double expense = await ExpensesHelper.expense();

    return [income - expense, income, expense];
  }

  Future<List<dynamic>> _initExpense() async {
    List<double> data = [];
    List<Color> color = [];

    for (var c in Category.values) {
      double temp = await ExpensesHelper.getExpenseAmountFor(
        c.label,
        start,
        end,
      );
      if (temp != 0.0) {
        data.add(temp);
        color.add(c.color);
      }
    }

    List<Expense> expenses = await ExpensesHelper.retrieve(3);

    return [data, color, expenses];
  }

  void read() async {
    debugPrint('${await ExpensesHelper.read()}');
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.homeTitle),
            Text(
              DateFormat('MMMM y').format(DateTime.now()),
              style: TextStyle(
                fontSize: 13,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              FutureBuilder<List<dynamic>>(
                future: _balanceFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error Retrieving Data'));
                  }
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return SummaryCard(
                    total: snapshot.data![0],
                    income: snapshot.data![1],
                    expense: snapshot.data![2],
                  );
                },
              ),
              SizedBox(height: 16),
              PeriodFilter(
                setPeriod: _setPeriod,
                selectedPeriod: _selectedPeriod,
              ),
              SizedBox(height: 16),
              FutureBuilder<List<dynamic>>(
                future: _expenseFuture,
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

                  return Column(
                    children: [
                      SpendingSummary(
                        period: _selectedPeriod.label,
                        chartColors: snapshot.data![1],
                        expenseData: snapshot.data![0],
                      ),
                      SizedBox(height: 36),
                      LatestTransactions(
                        openTransactionsScreen: _openTransactionsScreen,
                        openAddTransactionScreen: _openAddTransactionScreen,
                        expenses: snapshot.data![2],
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddTransactionScreen(null, false),
        child: Icon(Icons.add),
      ),
    );
  }
}
