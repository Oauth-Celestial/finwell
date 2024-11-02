import 'package:finwell/core/database/database_helper.dart';
import 'package:finwell/feature/pending_transactions/domain/entity/pending_transaction_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ultimate_extension/ultimate_extension.dart';

abstract interface class PendingTransactionDataSource {
  Future<List<PendingTransactionModel>> getPendingTransaction();
}

class PendingTransactionDataSourceImpl implements PendingTransactionDataSource {
  @override
  Future<List<PendingTransactionModel>> getPendingTransaction() async {
    // TODO: implement getPendingTransaction

    Database db = await DatabaseHelper().getDb();

    List<Map<String, dynamic>> pendingTransactionsData =
        await db.query("${DatabaseHelper().tableName}");
    print(pendingTransactionsData.first.prettyPrint());
    return pendingTransactionsData.map((transaction) {
      return PendingTransactionModel.fromMap(transaction);
    }).toList();
  }
}
