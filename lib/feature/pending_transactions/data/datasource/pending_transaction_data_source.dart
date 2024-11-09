import 'package:finwell/core/database/database_helper.dart';
import 'package:finwell/core/errors/failure.dart';
import 'package:finwell/feature/pending_transactions/domain/entity/pending_transaction_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ultimate_extension/ultimate_extension.dart';

abstract interface class PendingTransactionDataSource {
  Future<List<PendingTransactionModel>> getPendingTransaction();
  Future<bool> removePendingTransactions(
      PendingTransactionModel pendingTransaction);
}

class PendingTransactionDataSourceImpl implements PendingTransactionDataSource {
  @override
  Future<List<PendingTransactionModel>> getPendingTransaction() async {
    // TODO: implement getPendingTransaction

    Database db = await DatabaseHelper().getDb();

    List<Map<String, dynamic>> pendingTransactionsData = await db.query(
        "${DatabaseHelper().tableName}",
        where: "${DatabaseHelper().columnTransactionStatus} = ?",
        whereArgs: [0]);
    print(pendingTransactionsData.first.prettyPrint());
    return pendingTransactionsData.map((transaction) {
      return PendingTransactionModel.fromMap(transaction);
    }).toList();
  }

  @override
  Future<bool> removePendingTransactions(
      PendingTransactionModel pendingTransaction) async {
    // TODO: implement removePendingTransactions

    try {
      Database db = await DatabaseHelper().getDb();
      int result = await db.delete(DatabaseHelper().tableName,
          where: '${DatabaseHelper().columnTransactionId} = ?',
          whereArgs: [pendingTransaction.transactionId]);
      return result > 0;
    } catch (e) {
      throw Failure(failureMessage: "failed to delete record");
    }
  }
}
