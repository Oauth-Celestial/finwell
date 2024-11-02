// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:finwell/core/errors/failure.dart';
import 'package:finwell/feature/pending_transactions/data/datasource/pending_transaction_data_source.dart';
import 'package:finwell/feature/pending_transactions/domain/entity/pending_transaction_model.dart';
import 'package:finwell/feature/pending_transactions/domain/repository/pending_transaction_repo.dart';
import 'package:fpdart/src/either.dart';

class PendingRepoImpl implements PendingTransactionRepository {
  PendingTransactionDataSource pendingTransactionDataSource;
  PendingRepoImpl({
    required this.pendingTransactionDataSource,
  });
  @override
  Future<Either<Failure, List<PendingTransactionModel>>>
      getPendingTransaction() async {
    // TODO: implement getPendingTransaction
    try {
      List<PendingTransactionModel> transactions =
          await pendingTransactionDataSource.getPendingTransaction();
      return right(transactions);
    } catch (e) {
      return left(Failure(failureMessage: e.toString()));
    }
  }
}
