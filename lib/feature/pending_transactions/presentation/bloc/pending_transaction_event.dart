// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'pending_transaction_bloc.dart';

class PendingTransactionEvent extends Equatable {
  const PendingTransactionEvent();

  @override
  List<Object> get props => [];
}

class FetchPendingTransactionEvent extends PendingTransactionEvent {}

class DeletePendingTransactionEvent extends PendingTransactionEvent {
  PendingTransactionModel deleteTransaction;
  DeletePendingTransactionEvent({
    required this.deleteTransaction,
  });
}
