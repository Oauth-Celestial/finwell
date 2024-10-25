// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:finwell/core/errors/failure.dart';
import 'package:finwell/core/usecase/use_cases.dart';
import 'package:finwell/feature/transaction/domain/entities/transaction_model.dart';
import 'package:finwell/feature/transaction/domain/repository/transaction_repository.dart';
import 'package:fpdart/src/either.dart';

class CreateTransactionUsecase
    implements UseCases<TransactionModel, TransactionModel> {
  TransactionRepository transactionRepository;
  CreateTransactionUsecase({
    required this.transactionRepository,
  });

  @override
  Future<Either<Failure, TransactionModel>> call(TransactionModel parameters) {
    // TODO: implement call
    return transactionRepository.createTransaction(parameters);
  }
}
