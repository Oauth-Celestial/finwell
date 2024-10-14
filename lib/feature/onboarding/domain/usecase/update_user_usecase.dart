// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:finwell/core/errors/failure.dart';
import 'package:finwell/core/usecase/use_cases.dart';
import 'package:finwell/feature/onboarding/domain/entities/onboarding_model.dart';
import 'package:finwell/feature/onboarding/domain/repository/onboarding_repository.dart';
import 'package:fpdart/fpdart.dart';

class UpdateUserUsecase implements UseCases<bool, OnboardingModel> {
  OnboardingRepository onboardingRepository;
  UpdateUserUsecase({
    required this.onboardingRepository,
  });
  @override
  Future<Either<Failure, bool>> call(OnboardingModel parameters) async {
    // TODO: implement call
    return onboardingRepository.updateUser(parameters);
  }
}
