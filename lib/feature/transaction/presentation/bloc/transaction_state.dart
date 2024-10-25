// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'transaction_bloc.dart';

enum TransactionStatus {
  initial,
  creating,
  created,
  failed,
}

class TransactionState extends Equatable {
  TransactionStatus? status;
  TransactionModel? currentTransaction;
  TransactionState(
    this.status,
    this.currentTransaction,
  );

  static TransactionState initial() {
    return TransactionState(TransactionStatus.initial, null);
  }

  @override
  List<Object?> get props => [status, currentTransaction];

  TransactionState copyWith({
    TransactionStatus? status,
    TransactionModel? currentTransaction,
  }) {
    return TransactionState(
      status ?? this.status,
      currentTransaction ?? this.currentTransaction,
    );
  }
}
