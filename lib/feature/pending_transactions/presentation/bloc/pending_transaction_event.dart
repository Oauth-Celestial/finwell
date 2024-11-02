part of 'pending_transaction_bloc.dart';

class PendingTransactionEvent extends Equatable {
  const PendingTransactionEvent();

  @override
  List<Object> get props => [];
}

class FetchPendingTransactionEvent extends PendingTransactionEvent {}
