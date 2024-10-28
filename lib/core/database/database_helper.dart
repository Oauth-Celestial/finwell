import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static final DatabaseHelper _instance = DatabaseHelper._();

  Database? db;
  String dbName = "finwell.db";
  factory DatabaseHelper() {
    return _instance;
  }

  Future<Database> getDb() async {
    db ??= await openDb();
    return db!;
  }

  Future<Database> openDb() async {
    try {
      Directory parentDirectory = await getApplicationDocumentsDirectory();
      String dbPath = join(parentDirectory.path, dbName);

      print("dbPath -> ${dbPath}");

      return openDatabase(dbPath, onCreate: (db, version) {
        db.execute('''
          CREATE TABLE messages(
            id INTEGER PRIMARY KEY,
            message TEXT
          )
          ''');
      }, version: 1);
    } catch (e) {
      throw e;
    }
  }
}
