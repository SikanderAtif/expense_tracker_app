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

  static Future<List<Map<String,dynamic>>> read() async {
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

  static Future<double> getExpenseAmountFor(String category, DateTime start, DateTime end) async {
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

  /*
  static Future<Map<String, dynamic>> read(int id) async {
    Database db = await database;
    return db.query(
      "Expenses",
      
    )
  }
*/
}
