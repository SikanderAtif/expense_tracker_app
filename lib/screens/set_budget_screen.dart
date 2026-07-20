// ignore_for_file: deprecated_member_use

import 'package:expense_tracker_app/l10n/app_localizations.dart';
import 'package:expense_tracker_app/models/category.dart';
import 'package:expense_tracker_app/services/expense_helper.dart';
import 'package:expense_tracker_app/widgets/category_budget_input.dart';
import 'package:flutter/material.dart';

class SetBudgetScreen extends StatefulWidget {
  final double _budget;
  final bool update;

  const SetBudgetScreen({
    super.key,
    required this._budget,
    this.update = false,
  });

  @override
  State<SetBudgetScreen> createState() => _SetBudgetScreenState();
}

class _SetBudgetScreenState extends State<SetBudgetScreen> {
  final TextEditingController _foodController = TextEditingController();
  final TextEditingController _transitController = TextEditingController();
  final TextEditingController _shopController = TextEditingController();
  final TextEditingController _billsController = TextEditingController();
  final TextEditingController _entertainmentController =
      TextEditingController();
  final TextEditingController _healthController = TextEditingController();
  final TextEditingController _homeController = TextEditingController();
  final TextEditingController _educationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.update) {
      _loadData();
    }
  }

  @override
  void dispose() {
    _foodController.dispose();
    _transitController.dispose();
    _shopController.dispose();
    _billsController.dispose();
    _entertainmentController.dispose();
    _healthController.dispose();
    _homeController.dispose();
    _educationController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    List<dynamic> result = await ExpensesHelper.retrieveBudget();

    double food = result.firstWhere(
      (element) => element[0].label == Category.food.label,
    )[1];
    double transit = result.firstWhere(
      (element) => element[0].label == Category.transit.label,
    )[1];
    double shop = result.firstWhere(
      (element) => element[0].label == Category.shop.label,
    )[1];
    double bills = result.firstWhere(
      (element) => element[0].label == Category.bills.label,
    )[1];
    double entertainment = result.firstWhere(
      (element) => element[0].label == Category.entertainment.label,
    )[1];
    double health = result.firstWhere(
      (element) => element[0].label == Category.health.label,
    )[1];
    double home = result.firstWhere(
      (element) => element[0].label == Category.home.label,
    )[1];
    double edu = result.firstWhere(
      (element) => element[0].label == Category.edu.label,
    )[1];

    _foodController.text = food.toStringAsFixed(2);
    _transitController.text = transit.toStringAsFixed(2);
    _shopController.text = shop.toStringAsFixed(2);
    _billsController.text = bills.toStringAsFixed(2);
    _entertainmentController.text = entertainment.toStringAsFixed(2);
    _healthController.text = health.toStringAsFixed(2);
    _homeController.text = home.toStringAsFixed(2);
    _educationController.text = edu.toStringAsFixed(2);
  }

  void _setBudget(AppLocalizations locale) async {
    double food = double.tryParse(_foodController.text.trim()) ?? 0.0;
    double transit = double.tryParse(_transitController.text.trim()) ?? 0.0;
    double shop = double.tryParse(_shopController.text.trim()) ?? 0.0;
    double bills = double.tryParse(_billsController.text.trim()) ?? 0.0;
    double entertainment =
        double.tryParse(_entertainmentController.text.trim()) ?? 0.0;
    double health = double.tryParse(_healthController.text.trim()) ?? 0.0;
    double home = double.tryParse(_homeController.text.trim()) ?? 0.0;
    double edu = double.tryParse(_educationController.text.trim()) ?? 0.0;

    double sum =
        food + transit + shop + bills + entertainment + health + home + edu;

    if (sum > widget._budget) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.fixed,
          backgroundColor: Colors.black,
          content: Text(
            locale.overBudgetMessage((sum - widget._budget).toStringAsFixed(2)),
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        ),
      );
      return;
    }

    if (widget.update) {
      await Future.wait([
        ExpensesHelper.updateBudget(Category.food, food, DateTime.now()),
        ExpensesHelper.updateBudget(Category.transit, transit, DateTime.now()),
        ExpensesHelper.updateBudget(Category.shop, shop, DateTime.now()),
        ExpensesHelper.updateBudget(Category.bills, bills, DateTime.now()),
        ExpensesHelper.updateBudget(
          Category.entertainment,
          entertainment,
          DateTime.now(),
        ),
        ExpensesHelper.updateBudget(Category.health, health, DateTime.now()),
        ExpensesHelper.updateBudget(Category.home, home, DateTime.now()),
        ExpensesHelper.updateBudget(Category.edu, edu, DateTime.now()),
      ]);
    } else {
      await Future.wait([
        ExpensesHelper.insertBudget(Category.food, food, DateTime.now()),
        ExpensesHelper.insertBudget(Category.transit, transit, DateTime.now()),
        ExpensesHelper.insertBudget(Category.shop, shop, DateTime.now()),
        ExpensesHelper.insertBudget(Category.bills, bills, DateTime.now()),
        ExpensesHelper.insertBudget(
          Category.entertainment,
          entertainment,
          DateTime.now(),
        ),
        ExpensesHelper.insertBudget(Category.health, health, DateTime.now()),
        ExpensesHelper.insertBudget(Category.home, home, DateTime.now()),
        ExpensesHelper.insertBudget(Category.edu, edu, DateTime.now()),
      ]);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme color = Theme.of(context).colorScheme;
    final locale = AppLocalizations.of(context)!;
    final List<TextEditingController> controllerList = [
      _foodController,
      _transitController,
      _shopController,
      _billsController,
      _entertainmentController,
      _healthController,
      _homeController,
      _educationController,
    ];

    return Scaffold(
      appBar: AppBar(title: Text(locale.setBudget)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: color.secondary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: ListTile(
                  title: Text(
                    locale.monthlyBudget,
                    style: TextStyle(color: color.secondary, fontSize: 10),
                  ),
                  subtitle: Text(
                    '${locale.currency} ${widget._budget}',
                    style: TextStyle(
                      color: color.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),

              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: Category.values.length,
                itemBuilder: (BuildContext context, int index) {
                  Category category = Category.values[index];

                  return Column(
                    children: [
                      CategoryBudgetInput(
                        controller: controllerList[index],
                        category: category,
                      ),
                      SizedBox(height: 24),
                    ],
                  );
                },
              ),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {_setBudget(locale);},
                      child: Text(locale.setBudget),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
