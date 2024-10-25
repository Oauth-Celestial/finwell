import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:finwell/feature/transaction/domain/entities/transaction_model.dart';
import 'package:finwell/feature/transaction/domain/usecase/create_transaction_usecase.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  CreateTransactionUsecase _createTransactionUsecase;
  TransactionBloc({required CreateTransactionUsecase createtransactionusecase})
      : _createTransactionUsecase = createtransactionusecase,
        super(TransactionState.initial()) {
    on<CreateTransactionEvent>(_handleCreateTransaction);
  }

  void _handleCreateTransaction(
      CreateTransactionEvent event, Emitter<TransactionState> emit) async {
    emit(state.copyWith(
        status: TransactionStatus.creating,
        currentTransaction: event.transaction));
    final response = await _createTransactionUsecase(event.transaction);
    response.fold((failure) {
      emit(state.copyWith(
          status: TransactionStatus.failed, currentTransaction: null));
    }, (success) {
      emit(state.copyWith(
          status: TransactionStatus.created, currentTransaction: success));
    });
  }
}
