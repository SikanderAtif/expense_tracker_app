import 'package:expense_tracker_app/models/category.dart';
import 'package:expense_tracker_app/models/transaction_type.dart';
import 'package:expense_tracker_app/services/storage.dart';
import 'package:expense_tracker_app/models/expense.dart';
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

static Future<List<Expense>> retrieveBy(String filterType, String filter) async {
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

  static Future<double> income() async {
    Database db = await database;
    final List<Map<String, Object?>> result = await db.rawQuery(
      'SELECT SUM(Amount) AS Total FROM Expenses WHERE Type = ?',
      ['Income'],
    );
    final Object? value = result.first['Total'];

    if (value is num) {
      return value.toDouble();
    }

    return 0.0;
  }

  static Future<double> expense() async {
    Database db = await database;
    final List<Map<String, Object?>> result = await db.rawQuery(
      'SELECT SUM(Amount) AS Total FROM Expenses WHERE Type = ?',
      ['Expense'],
    );
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

  static Future<void> dropDB() async {
    await Storage.removeDB('expenses_database');
    print("Successfully Dropped Database");
  }

}
