import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:finwell/core/errors/failure.dart';
import 'package:finwell/core/usecase/use_cases.dart';
import 'package:finwell/feature/pending_transactions/domain/entity/pending_transaction_model.dart';
import 'package:finwell/feature/pending_transactions/domain/usecase/pending_transaction_usecase.dart';
import 'package:finwell/feature/pending_transactions/domain/usecase/remove_pending_transaction_usecase.dart';
import 'package:fpdart/fpdart.dart';

part 'pending_transaction_event.dart';
part 'pending_transaction_state.dart';

class PendingTransactionBloc
    extends Bloc<PendingTransactionEvent, PendingTransactionState> {
  PendingTransactionUsecase _pendingTransactionUsecase;
  RemovePendingTransactionUsecase _removePendingTransactionUsecase;
  PendingTransactionBloc(
      {required PendingTransactionUsecase pendingTransactionUsecase,
      required RemovePendingTransactionUsecase
          removePendingTransactionsUseCase})
      : _pendingTransactionUsecase = pendingTransactionUsecase,
        _removePendingTransactionUsecase = removePendingTransactionsUseCase,
        super(PendingTransactionState.initial()) {
    on<FetchPendingTransactionEvent>(_fetchPendingTransaction);
    on<DeletePendingTransactionEvent>(_deletePendingTransaction);
  }

  void _fetchPendingTransaction(FetchPendingTransactionEvent event,
      Emitter<PendingTransactionState> emit) async {
    Either<Failure, List<PendingTransactionModel>> pendingTrans =
        await _pendingTransactionUsecase(NoParamsType());

    pendingTrans.fold((failure) {
      emit(state.copyWith(status: PendingTransactionStatus.failed));
    }, (success) {
      emit(state.copyWith(
          status: PendingTransactionStatus.fetched, data: success));
    });
  }

  void _deletePendingTransaction(DeletePendingTransactionEvent event,
      Emitter<PendingTransactionState> emit) async {
    Either<Failure, bool> result =
        await _removePendingTransactionUsecase(event.deleteTransaction);

    await result.fold((failure) {
      emit(state.copyWith(status: PendingTransactionStatus.failed));
    }, (success) async {
      Either<Failure, List<PendingTransactionModel>> pendingTrans =
          await _pendingTransactionUsecase(NoParamsType());

      pendingTrans.fold((failure) {
        emit(state.copyWith(status: PendingTransactionStatus.failed));
      }, (success) {
        emit(state.copyWith(
            status: PendingTransactionStatus.fetched, data: success));
      });
    });
  }
}
