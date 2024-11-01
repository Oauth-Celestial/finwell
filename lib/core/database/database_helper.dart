import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static final DatabaseHelper _instance = DatabaseHelper._();

  Database? db;
  String dbName = "finwell.db";
  String tableName = "transactions";
  String columnAmount = "TransactionAmount";
  String columnCategory = "TransactionCategory";
  String columnDate = "TransactionDate";
  String columnTransactionId = "TransactionId";
  String columnTransactionName = "TransactionName";
  String columnTransactionType = "TransactionType";
  String columnTransactionStatus = "TransactionStatus";

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
          CREATE TABLE ${tableName} (
    id INTEGER PRIMARY KEY,
    ${columnAmount} TEXT NOT NULL,
    ${columnCategory} TEXT NOT NULL,
    ${columnDate} INTEGER NOT NULL,
    ${columnTransactionId} TEXT,
    ${columnTransactionName} TEXT NOT NULL,
   ${columnTransactionType} TEXT NOT NULL,
   ${columnTransactionStatus} BOOLEAN NOT NULL
          );
          ''');
      }, version: 1);
    } catch (e) {
      throw e;
    }
  }
}
