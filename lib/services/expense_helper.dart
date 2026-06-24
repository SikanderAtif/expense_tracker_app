import 'package:sqflite/sqflite.dart';
import 'storage_service.dart';

class ExpenseDatabaseHelper {
  static Database? db;

  static void init() async {
    db = await Storage.initialize('expense_database');
  }
}
