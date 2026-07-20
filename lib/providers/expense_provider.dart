import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/services/expense_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class ExpenseNotifier extends AsyncNotifier<List<Expense>> {
  @override
  Future<List<Expense>> build() async {
    return await ExpensesHelper.retrieve(null);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => ExpensesHelper.retrieve(null));
  }
}

final expenseProvider = AsyncNotifierProvider<ExpenseNotifier, List<Expense>>(
  () {
    return ExpenseNotifier();
  },
);

class BudgetNotifier extends AsyncNotifier<List<dynamic>> {
  @override
  Future<List<dynamic>> build() async {
    return await ExpensesHelper.retrieveBudget();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => ExpensesHelper.retrieveBudget());
  }
}

final budgetProvider = AsyncNotifierProvider<BudgetNotifier, List<dynamic>>(() {
  return BudgetNotifier();
});

final statsTabKeyProvider = StateProvider<int>((ref) => 0);
final budgetTabKeyProvider = StateProvider<int>((ref) => 0);