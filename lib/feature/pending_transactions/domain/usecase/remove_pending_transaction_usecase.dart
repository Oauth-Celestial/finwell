import 'package:finwell/core/errors/failure.dart';
import 'package:finwell/core/usecase/use_cases.dart';
import 'package:finwell/feature/pending_transactions/domain/entity/pending_transaction_model.dart';
import 'package:finwell/feature/pending_transactions/domain/repository/pending_transaction_repo.dart';
import 'package:fpdart/src/either.dart';

class RemovePendingTransactionUsecase
    implements UseCases<bool, PendingTransactionModel> {
  PendingTransactionRepository pendingTransactionRepository;

  RemovePendingTransactionUsecase({required this.pendingTransactionRepository});
  @override
  Future<Either<Failure, bool>> call(PendingTransactionModel parameters) {
    // TODO: implement call
    return pendingTransactionRepository.removePendingTransactions(parameters);
  }
}
