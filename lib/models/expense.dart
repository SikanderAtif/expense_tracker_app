import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker_app/models/category.dart';
import 'package:expense_tracker_app/models/transaction_type.dart';

class Expense {
  int? id;
  String text = '';
  double amount = 0;
  TType type = TType.expense;
  Category category = Category.food;
  DateTime timestamp = DateTime.now();

  Expense(this.text, this.amount, this.type, this.category, this.timestamp);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'Text': text,
      'Amount': amount,
      'Type': type.label,
      'Category': category.label,
      'TimeStamp': timestamp,
    };

    return map;
  }

  static Expense fromMap(Map<String, dynamic> map) {
    String text = map['Text'];
    double amount = (map['Amount'] is int) ? (map['Amount'] as int).toDouble() : map['Amount'];
    String sType = map['Type'];
    String sCategory = map['Category'];

    TType type = TType.values.firstWhere((t) => t.label == sType);
    Category category = Category.values.firstWhere((c) => c.label == sCategory);
    DateTime timestamp;
    if (map['TimeStamp'] is Timestamp) {
      timestamp = (map['TimeStamp'] as Timestamp).toDate();
    } else if (map['TimeStamp'] is String) {
      timestamp = DateTime.parse(map['TimeStamp']);
    } else {
      timestamp = map['TimeStamp'] as DateTime;
    }

    return Expense(text, amount, type, category, timestamp);
  }
}