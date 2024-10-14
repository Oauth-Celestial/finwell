// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:finwell/core/errors/failure.dart';
import 'package:finwell/feature/onboarding/data/datasource/onboarding_datasource.dart';
import 'package:finwell/feature/onboarding/domain/entities/onboarding_model.dart';
import 'package:finwell/feature/onboarding/domain/repository/onboarding_repository.dart';
import 'package:fpdart/fpdart.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  OnboardingDatasource datasource;
  OnboardingRepositoryImpl({
    required this.datasource,
  });
  @override
  Future<Either<Failure, bool>> updateUser(OnboardingModel user) async {
    try {
      bool result = await datasource.updateUser(user);

      return right(result);
    } catch (e) {
      return left(e as Failure);
    }
  }
}
