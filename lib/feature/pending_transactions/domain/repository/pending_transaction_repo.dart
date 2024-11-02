import 'package:finwell/core/errors/failure.dart';
import 'package:finwell/feature/pending_transactions/domain/entity/pending_transaction_model.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class PendingTransactionRepository {
  Future<Either<Failure, List<PendingTransactionModel>>>
      getPendingTransaction();
}
