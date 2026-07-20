import 'package:expense_tracker_app/l10n/app_localizations.dart';
import 'package:expense_tracker_app/models/category.dart';
import 'package:expense_tracker_app/screens/set_budget_screen.dart';
import 'package:expense_tracker_app/services/expense_helper.dart';
import 'package:expense_tracker_app/utils/date_time_extension.dart';
import 'package:expense_tracker_app/widgets/category_list.dart';
import 'package:expense_tracker_app/widgets/empty_budget_state.dart';
import 'package:expense_tracker_app/widgets/monthly_budget_card.dart';
import 'package:flutter/material.dart';

class BudgetPage extends StatefulWidget {
  const BudgetPage({super.key});

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  late Future<List<dynamic>> _expenseFuture;

  @override
  void initState() {
    super.initState();
    _expenseFuture = _initBudget();
  }

  void _refreshData() {
    setState(() {
      _expenseFuture = _initBudget();
    });
  }

  void _openSetBudgetScreen(double budget, {bool update = false}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SetBudgetScreen(budget: budget, update: update),
      ),
    );

    _refreshData();
  }

  Future<List<dynamic>> _initBudget() async {
    final DateTime start = DateTime.now().currentMonthRange.start;
    final DateTime end = DateTime.now().currentMonthRange.end;

    final double budget = await ExpensesHelper.income(start: start, end: end);
    final double spent = await ExpensesHelper.expense(start: start, end: end);
    final double remaining = budget - spent;

    final List<dynamic> spentList = [];
    for (Category c in Category.values) {
      spentList.add([
        await ExpensesHelper.getExpenseAmountFor(c.label, start, end),
        c,
      ]);
    }

    final List<dynamic> categoryList = await ExpensesHelper.retrieveBudget(
      range: DateTime.now().currentMonthRange,
    );

    return [budget, spent, remaining, spentList, categoryList];
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme color = Theme.of(context).colorScheme;
    final locale = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(locale.budget)),
      body: RefreshIndicator(
        onRefresh: () async {
          _refreshData();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: FutureBuilder(
              future: _expenseFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text(locale.errorRetrieving));
                }
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MonthlyBudgetCard(
                      budget: snapshot.data![0],
                      spent: snapshot.data![1],
                      remaining: snapshot.data![2],
                    ),
                    SizedBox(height: 24),
                    Text(
                      locale.budgetHeading,
                      style: TextStyle(
                        color: color.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    snapshot.data![4].isEmpty
                        ? EmptyBudgetState(
                            openSetBudgetScreen: _openSetBudgetScreen,
                            budget: snapshot.data![0],
                          )
                        : CategoryList(
                            spent: snapshot.data![3],
                            list: snapshot.data![4],
                          ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              _openSetBudgetScreen(
                                snapshot.data![0],
                                update: true,
                              );
                            },
                            child: Text(
                              locale.budgetButton,
                              style: TextStyle(color: color.primary),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
