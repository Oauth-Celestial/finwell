import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:finwell/core/errors/failure.dart';
import 'package:finwell/core/extensions/ext_date_time.dart';
import 'package:finwell/feature/dashboard/domain/entities/dashboard_model.dart';
import 'package:finwell/feature/dashboard/domain/usecase/dashboard_details_use_case.dart';
import 'package:fpdart/fpdart.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardDetailsUseCase _dashboardDetailsUseCase;
  DashboardBloc({required DashboardDetailsUseCase dashboardDetailsUseCase})
      : _dashboardDetailsUseCase = dashboardDetailsUseCase,
        super(DashboardState.initial()) {
    on<LoadDashBoardEvent>(_handleLoadDashBoard);
  }

  void _handleLoadDashBoard(
      LoadDashBoardEvent event, Emitter<DashboardState> emit) async {
    emit(state.copyWith(status: DashboardStatus.loading));
    DateTime today = DateTime.now();
    Either<Failure, DashboardModel> result = await _dashboardDetailsUseCase(
      DetailParams(
        year: today.year.toString(),
        month: today.monthName.toLowerCase(),
      ),
    );

    await result.fold((failure) {
      emit(state.copyWith(status: DashboardStatus.failed));
    }, (success) {
      emit(state.copyWith(status: DashboardStatus.loaded, data: success));
    });
  }
}
