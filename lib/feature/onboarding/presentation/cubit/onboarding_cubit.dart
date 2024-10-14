import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:finwell/feature/onboarding/domain/entities/onboarding_model.dart';
import 'package:finwell/feature/onboarding/domain/usecase/update_user_usecase.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final UpdateUserUsecase _updateUserUsecase;
  OnboardingCubit({required UpdateUserUsecase usecase})
      : _updateUserUsecase = usecase,
        super(OnboardingState.initial());

  void updateUserName({required String name}) {
    OnboardingModel userData = OnboardingModel(name: name);
    emit(
      state.copyWith(
        status: OnboardingStatus.inprocess,
        userData: userData,
      ),
    );
  }

  void updateMonthlyIncome({required int monthlyIncome}) {
    OnboardingModel userData =
        state.userData!.copyWith(montlyIncome: monthlyIncome);
    emit(
      state.copyWith(
        status: OnboardingStatus.inprocess,
        userData: userData,
      ),
    );
  }

  void updateMonthlyExpense({required int monthlyExpense}) {
    OnboardingModel userData =
        state.userData!.copyWith(monthlyExpense: monthlyExpense);
    emit(
      state.copyWith(
        status: OnboardingStatus.inprocess,
        userData: userData,
      ),
    );
    _updateUserUsecase(userData);
  }
}
