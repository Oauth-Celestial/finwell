import 'package:finwell/core/app_user/model/app_user_model.dart';
import 'package:finwell/core/errors/failure.dart';
import 'package:finwell/core/usecase/use_cases.dart';
import 'package:finwell/feature/auth/domain/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/src/either.dart';

class CreateUserUseCase implements UseCases<AppUserModel, User> {
  AuthRepository authRepository;
  CreateUserUseCase({
    required this.authRepository,
  });

  @override
  Future<Either<Failure, AppUserModel>> call(User parameters) {
    // TODO: implement call
    return authRepository.createUser(user: parameters);
  }
}
