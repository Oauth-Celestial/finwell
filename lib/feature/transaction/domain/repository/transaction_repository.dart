import 'package:finwell/core/errors/failure.dart';
import 'package:finwell/feature/transaction/domain/entities/transaction_model.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class TransactionRepository {
  Future<Either<Failure, TransactionModel>> createTransaction(
      TransactionModel transactionData);
}
