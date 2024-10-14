// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'onboarding_cubit.dart';

enum OnboardingStatus { initial, inprocess, done }

class OnboardingState extends Equatable {
  OnboardingStatus? status;
  OnboardingModel? userData;
  OnboardingState({this.status, this.userData});

  static OnboardingState initial() {
    return OnboardingState(status: OnboardingStatus.initial);
  }

  @override
  List<Object?> get props => [status, userData];

  OnboardingState copyWith({
    OnboardingStatus? status,
    OnboardingModel? userData,
  }) {
    return OnboardingState(
      status: status ?? this.status,
      userData: userData ?? this.userData,
    );
  }
}
