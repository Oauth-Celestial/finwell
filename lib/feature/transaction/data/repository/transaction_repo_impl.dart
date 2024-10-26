// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:finwell/core/errors/failure.dart';
import 'package:finwell/feature/transaction/data/datasource/transaction_data_source.dart';
import 'package:finwell/feature/transaction/domain/entities/transaction_model.dart';
import 'package:finwell/feature/transaction/domain/repository/transaction_repository.dart';
import 'package:fpdart/src/either.dart';

class TransactionRepoImpl implements TransactionRepository {
  TransactionDataSource dataSource;
  TransactionRepoImpl({
    required this.dataSource,
  });
  @override
  Future<Either<Failure, TransactionModel>> createTransaction(
      TransactionModel transactionData) async {
    // TODO: implement createTransaction
    try {
      TransactionModel response =
          await dataSource.createTransaction(transactionData);
      return right(response);
    } catch (e) {
      return left(e as Failure);
    }
  }

  @override
  Future<Either<Failure, List<TransactionModel>>> fetchTransaction(
      String transactionDate) async {
    // TODO: implement fetchTransaction
    try {
      List<TransactionModel> transaction =
          await dataSource.fetchTransaction(transactionDate);
      return right(transaction);
    } catch (e) {
      return left(e as Failure);
    }
  }
}
