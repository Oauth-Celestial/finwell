import 'package:finwell/core/errors/failure.dart';
import 'package:finwell/core/usecase/use_cases.dart';
import 'package:finwell/feature/auth/domain/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/src/either.dart';

class CreateUserUseCase implements UseCases<bool, User> {
  AuthRepository authRepository;
  CreateUserUseCase({
    required this.authRepository,
  });

  @override
  Future<Either<Failure, bool>> call(User parameters) {
    // TODO: implement call
    return authRepository.createUser(user: parameters);
  }
}
