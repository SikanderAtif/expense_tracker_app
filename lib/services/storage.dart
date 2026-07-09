import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Storage {
  static Future<Database> init(String dbName) async {
    return await openDatabase(
      join(await getDatabasesPath(), '$dbName.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE Expenses (ID INTEGER PRIMARY KEY, Desc TEXT, Amount REAL, Type TEXT, Category TEXT, TimeStamp TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> removeDB(String dbName) async {
    String devicesPath = await getDatabasesPath();
    String path = join(devicesPath, '$dbName.db');

    await deleteDatabase(path);
  }
}
