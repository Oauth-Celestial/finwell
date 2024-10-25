// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'transaction_bloc.dart';

sealed class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class CreateTransactionEvent extends TransactionEvent {
  TransactionModel transaction;
  CreateTransactionEvent({
    required this.transaction,
  });
}
