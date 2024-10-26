import 'package:finwell/core/errors/failure.dart';
import 'package:finwell/core/usecase/use_cases.dart';
import 'package:finwell/feature/transaction/domain/entities/transaction_model.dart';
import 'package:finwell/feature/transaction/domain/repository/transaction_repository.dart';
import 'package:fpdart/src/either.dart';

class FetchTransactionUsecase
    implements UseCases<List<TransactionModel>, String> {
  TransactionRepository transactionRepository;
  FetchTransactionUsecase({required this.transactionRepository});
  @override
  Future<Either<Failure, List<TransactionModel>>> call(String parameters) {
    // TODO: implement call
    return transactionRepository.fetchTransaction(parameters);
  }
}
