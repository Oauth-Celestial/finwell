// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'transaction_bloc.dart';

enum TransactionStatus { initial, creating, created, failed, loading, fetched }

class TransactionState extends Equatable {
  TransactionStatus? status;
  TransactionModel? currentTransaction;
  List<TransactionModel>? fetchedTransactions;
  TransactionState({
    this.status,
    this.currentTransaction,
    this.fetchedTransactions,
  });

  static TransactionState initial() {
    return TransactionState(status: TransactionStatus.initial);
  }

  @override
  List<Object?> get props => [status, currentTransaction];

  TransactionState copyWith(
      {TransactionStatus? status,
      TransactionModel? currentTransaction,
      List<TransactionModel>? fetchedTransactions}) {
    return TransactionState(
        status: status ?? this.status,
        currentTransaction: currentTransaction ?? this.currentTransaction,
        fetchedTransactions: fetchedTransactions ?? this.fetchedTransactions);
  }
}
