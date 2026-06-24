import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Storage {
  static Future<Database> initialize(String dbName) async {
    final database = openDatabase(
      join(await getDatabasesPath(), '$dbName.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE Expenses (ID INTEGER PRIMARY KEY, Name TEXT, Description TEXT, Amount INTEGER)',
        );
      },
      version: 1,
    );

    final db = await database;
    Map<String, dynamic> row = {
      'Name': 'Honda Civic 2017',
      'Description':
          'Bought used Honda Civic 2017 model which is just like new.',
      'Amount': 5000000,
    };
    await db.insert('Expenses', row);
    List<Map<String, dynamic>> expenses = await db.query('Expenses');
    print(expenses);

    return db;
  }
}
