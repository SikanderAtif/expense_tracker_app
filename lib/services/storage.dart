import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Storage {
  static Future<Database> init(String dbName) async {
    return await openDatabase(
      join(await getDatabasesPath(), '$dbName.db'),
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE Expenses (ID INTEGER PRIMARY KEY, Desc TEXT, Amount REAL, Type TEXT, Category TEXT, TimeStamp TEXT)',
        );
        await db.execute(
          'CREATE TABLE Budget (ID INTEGER PRIMARY KEY, Category TEXT, limitValue REAL, TimeStamp TEXT)',
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute(
            'CREATE TABLE Budget (ID INTEGER PRIMARY KEY, Category TEXT, limitValue REAL, TimeStamp TEXT)',
          );
        }
      },
      version: 2,
    );
  }

  static Future<void> removeDB(String dbName) async {
    String devicesPath = await getDatabasesPath();
    String path = join(devicesPath, '$dbName.db');

    await deleteDatabase(path);
  }
}
