import 'dart:io';

import 'package:finwell/feature/transaction/domain/entities/transaction_model.dart';
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
  String columnTransactionMonth = "TransactionMonth";
  String columnTrasactionYear = "TransactionYear";

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
   ${columnTransactionMonth} TEXT NOT NULL,
   ${columnTrasactionYear} TEXT NOT NULL,
   ${columnTransactionStatus} BOOLEAN NOT NULL
          );
          ''');
      }, version: 1);
    } catch (e) {
      throw e;
    }
  }

  insertTransaction(TransactionModel? transactiondata) async {
    Database db = await getDb();
    int result = await db.insert(tableName, {
      columnAmount: transactiondata?.transactionAmount.toString(),
      columnTransactionId: transactiondata?.transactionId,
      columnCategory: transactiondata?.transactionCategory,
      columnDate: transactiondata?.transactionDate.millisecondsSinceEpoch,
      columnTransactionName: transactiondata?.transactionName,
      columnTransactionType: transactiondata?.transactionType,
      columnTransactionStatus: 1,
      columnTransactionMonth: transactiondata?.transactionMonth?.toLowerCase(),
      columnTrasactionYear: transactiondata?.transactionYear
    });
    print(result);
  }
}
