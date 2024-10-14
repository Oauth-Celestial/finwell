import 'package:finwell/core/errors/failure.dart';
import 'package:finwell/core/usecase/use_cases.dart';
import 'package:finwell/feature/auth/domain/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

class GoogleLoginUseCase implements UseCases<User, NoParamsType> {
  final AuthRepository repository;

  GoogleLoginUseCase({required this.repository});
  @override
  Future<Either<Failure, User>> call(NoParamsType parameters) {
    return repository.loginWithGoogle();
  }
}
