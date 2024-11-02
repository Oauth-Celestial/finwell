import 'package:finwell/core/errors/failure.dart';
import 'package:finwell/core/usecase/use_cases.dart';
import 'package:finwell/feature/pending_transactions/domain/entity/pending_transaction_model.dart';
import 'package:finwell/feature/pending_transactions/domain/repository/pending_transaction_repo.dart';
import 'package:fpdart/src/either.dart';

class PendingTransactionUsecase
    implements UseCases<List<PendingTransactionModel>, NoParamsType> {
  PendingTransactionRepository pendingTransactionRepository;
  PendingTransactionUsecase({required this.pendingTransactionRepository});
  @override
  Future<Either<Failure, List<PendingTransactionModel>>> call(
      NoParamsType parameters) {
    return pendingTransactionRepository.getPendingTransaction();
  }
}
