// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'pending_transaction_bloc.dart';

enum PendingTransactionStatus { initial, loading, fetched, failed }

class PendingTransactionState extends Equatable {
  PendingTransactionStatus? status;
  List<PendingTransactionModel>? data;

  PendingTransactionState(
    this.status,
    this.data,
  );

  static PendingTransactionState initial() {
    return PendingTransactionState(PendingTransactionStatus.initial, []);
  }

  @override
  List<Object?> get props => [status, data];

  PendingTransactionState copyWith({
    PendingTransactionStatus? status,
    List<PendingTransactionModel>? data,
  }) {
    return PendingTransactionState(
      status ?? this.status,
      data ?? this.data,
    );
  }
}
