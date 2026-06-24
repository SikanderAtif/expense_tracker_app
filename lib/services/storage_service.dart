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

    return await database;
  }
}
