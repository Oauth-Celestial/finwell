import 'package:finwell/core/errors/failure.dart';
import 'package:finwell/feature/onboarding/domain/entities/onboarding_model.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class OnboardingRepository {
  Future<Either<Failure, bool>> updateUser(OnboardingModel user);
}
