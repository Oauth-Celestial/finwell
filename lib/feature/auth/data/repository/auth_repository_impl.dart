import 'package:finwell/core/errors/failure.dart';
import 'package:finwell/feature/auth/data/datasource/auth_data_source.dart';
import 'package:finwell/feature/auth/domain/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthDataSource authDataSource;
  AuthRepositoryImpl({
    required this.authDataSource,
  });
  @override
  Future<Either<Failure, User>> loginWithGoogle() async {
    try {
      User result = await authDataSource.loginWithGoogle();

      return right(result);
    } catch (e) {
      return left(e as Failure);
    }
  }

  @override
  Future<Either<Failure, bool>> createUser({required User user}) async {
    try {
      bool result = await authDataSource.createUser(user: user);

      return right(result);
    } catch (e) {
      return left(e as Failure);
    }
  }
}
