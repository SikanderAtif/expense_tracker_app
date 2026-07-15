import 'package:expense_tracker_app/models/category.dart';
import 'package:expense_tracker_app/models/transaction_type.dart';
import 'package:expense_tracker_app/services/storage.dart';
import 'package:expense_tracker_app/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class ExpensesHelper {
  static Database? _db;

  static Future<Database> get database async {
    if (_db == null) {
      await init();
      return _db!;
    }

    return _db!;
  }

  static Future<void> init() async {
    _db = await Storage.init("expenses_database");
  }

  static Future<List<Map<String, dynamic>>> read() async {
    Database db = await database;
    return await db.query('Expenses');
  }

  static Future<void> insert(Expense e) async {
    Database db = await database;
    await db.insert("Expenses", {
      "Desc": e.text,
      "Amount": e.amount,
      "Type": e.type.label,
      "Category": e.category.label,
      "TimeStamp": e.timestamp.toIso8601String(),
    });
  }

  static Future<void> insertBudget(
    Category c,
    double limit,
    DateTime date,
  ) async {
    Database db = await database;
    await db.insert('Budget', {
      "Category": c.label,
      "limitValue": limit,
      "TimeStamp": date.toIso8601String(),
    });
  }

  static Future<void> updateBudget(
    Category c,
    double limit,
    DateTime date,
  ) async {
    Database db = await database;
    await db.update(
      'Budget',
      {
        "Category": c.label,
        "limitValue": limit,
        "TimeStamp": date.toIso8601String(),
      },
      where: "Category = ?",
      whereArgs: [c.label],
    );
  }

  static Future<List<dynamic>> retrieveBudget({
    Category? c,
    DateTimeRange? range,
  }) async {
    Database db = await database;
    final List<dynamic> output = [];

    List<Map<String, dynamic>> result = await db.query(
      'Budget',
      where: c != null
          ? (range != null
                ? 'Category = ? AND TimeStamp BETWEEN ? AND ?'
                : 'Category = ?')
          : (range != null ? 'TimeStamp BETWEEN ? AND ?' : null),
      whereArgs: c != null
          ? (range != null ? [c.label, range.start.toIso8601String(), range.end.toIso8601String()] : [c.label])
          : (range != null ? [range.start.toIso8601String(), range.end.toIso8601String()] : null),
    );

    for (int i = 0; i < result.length; i++) {
      String sCategory = result[i]['Category'];
      double limit = result[i]['limitValue'];

      Category category = Category.values.firstWhere(
        (c) => c.label == sCategory,
      );

      output.add([category, limit]);
    }

    return output;
  }

  static Future<List<Expense>> retrieve(int? amt) async {
    Database db = await database;
    List<Expense> result = [];
    List<Map<String, dynamic>> list;

    if (amt == null) {
      list = await db.query("Expenses", orderBy: 'TimeStamp DESC');
    } else {
      list = await db.query('Expenses', orderBy: 'TimeStamp DESC', limit: amt);
    }

    for (Map<String, dynamic> e in list) {
      String text = e['Desc'];
      double amount = e['Amount'];
      String tempType = e['Type'];
      String tempCategory = e['Category'];
      DateTime time = DateTime.parse(e['TimeStamp']);

      TType type = TType.values.firstWhere((t) => t.label == tempType);

      Category category = Category.values.firstWhere(
        (c) => c.label == tempCategory,
      );

      Expense exp = Expense(text, amount, type, category, time);
      result.add(exp);
    }

    return result;
  }

  static Future<List<Expense>> retrieveBy(
    String filterType,
    String filter,
  ) async {
    Database db = await database;
    List<Expense> result = [];
    List<Map<String, dynamic>> list;

    list = await db.query(
      'Expenses',
      where: '$filterType = ?',
      whereArgs: [filter],
      orderBy: 'TimeStamp DESC',
    );

    for (Map<String, dynamic> e in list) {
      String text = e['Desc'];
      double amount = e['Amount'];
      String tempType = e['Type'];
      String tempCategory = e['Category'];
      DateTime time = DateTime.parse(e['TimeStamp']);

      TType type = TType.values.firstWhere((t) => t.label == tempType);

      Category category = Category.values.firstWhere(
        (c) => c.label == tempCategory,
      );

      Expense exp = Expense(text, amount, type, category, time);
      result.add(exp);
    }

    return result;
  }

  static Future<List<Expense>> search(String filter) async {
    Database db = await database;
    List<Expense> result = [];
    List<Map<String, dynamic>> list;

    list = await db.query(
      'Expenses',
      where: 'Desc LIKE ?',
      whereArgs: ['%$filter%'],
      orderBy: 'TimeStamp DESC',
    );

    for (Map<String, dynamic> e in list) {
      String text = e['Desc'];
      double amount = e['Amount'];
      String tempType = e['Type'];
      String tempCategory = e['Category'];
      DateTime time = DateTime.parse(e['TimeStamp']);

      TType type = TType.values.firstWhere((t) => t.label == tempType);

      Category category = Category.values.firstWhere(
        (c) => c.label == tempCategory,
      );

      Expense exp = Expense(text, amount, type, category, time);
      result.add(exp);
    }

    return result;
  }

  static Future<double> income({DateTime? start, DateTime? end}) async {
    Database db = await database;
    final List<Map<String, Object?>> result;

    if (start != null && end != null) {
      result = await db.rawQuery(
        'SELECT SUM(Amount) AS Total FROM Expenses WHERE Type = ? AND TimeStamp >= ? AND TimeStamp <= ?',
        ['Income', start.toIso8601String(), end.toIso8601String()],
      );
    } else {
      result = await db.rawQuery(
        'SELECT SUM(Amount) AS Total FROM Expenses WHERE Type = ?',
        ['Income'],
      );
    }

    final Object? value = result.first['Total'];

    if (value is num) {
      return value.toDouble();
    }

    return 0.0;
  }

  static Future<double> expense({DateTime? start, DateTime? end}) async {
    Database db = await database;
    final List<Map<String, Object?>> result;

    if (start != null && end != null) {
      result = await db.rawQuery(
        'SELECT SUM(Amount) AS Total FROM Expenses WHERE Type = ? AND TimeStamp >= ? AND TimeStamp <= ?',
        ['Expense', start.toIso8601String(), end.toIso8601String()],
      );
    } else {
      result = await db.rawQuery(
        'SELECT SUM(Amount) AS Total FROM Expenses WHERE Type = ?',
        ['Expense'],
      );
    }

    final Object? value = result.first['Total'];

    if (value is num) {
      return value.toDouble();
    }

    return 0.0;
  }

  static Future<double> getExpenseAmountFor(
    String category,
    DateTime start,
    DateTime end,
  ) async {
    Database db = await database;
    final List<Map<String, Object?>> result = await db.rawQuery(
      'SELECT SUM(Amount) AS Total FROM Expenses WHERE Type = ? AND Category = ? AND TimeStamp >= ? AND TimeStamp <= ?',
      ['Expense', category, start.toIso8601String(), end.toIso8601String()],
    );
    final Object? value = result.first['Total'];

    if (value is num) {
      return value.toDouble();
    }

    return 0.0;
  }

  static Future<List<Expense>> getSpendingFlow(
    DateTime start,
    DateTime end,
  ) async {
    Database db = await database;
    List<Expense> data = [];
    List<Map<String, dynamic>> temp;

    temp = await db.query(
      'Expenses',
      where: 'TimeStamp >= ? AND TimeStamp <= ?',
      whereArgs: [start.toIso8601String(), end.toIso8601String()],
      orderBy: 'TimeStamp DESC',
    );

    for (Map<String, dynamic> t in temp) {
      String text = t['Desc'];
      double amount = t['Amount'];
      String sType = t['Type'];
      String sCategory = t['Category'];
      DateTime timestamp = DateTime.parse(t['TimeStamp']);

      TType type = TType.values.firstWhere((t) => t.label == sType);

      Category category = Category.values.firstWhere(
        (c) => c.label == sCategory,
      );

      Expense e = Expense(text, amount, type, category, timestamp);
      data.add(e);
    }

    return data;
  }

  static Future<void> dropDB() async {
    await Storage.removeDB('expenses_database');
    print("Successfully Dropped Database");
  }
}
