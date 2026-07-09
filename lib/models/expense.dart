import 'package:expense_tracker_app/models/category.dart';
import 'package:expense_tracker_app/models/transaction_type.dart';

class Expense {
  String text = '';
  double amount = 0;
  TType type = TType.expense;
  Category category = Category.food;
  DateTime timestamp = DateTime.now();

  Expense(this.text, this.amount, this.type, this.category, this.timestamp);
}