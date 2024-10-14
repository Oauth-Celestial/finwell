import 'package:finwell/core/errors/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> loginWithGoogle();
  Future<Either<Failure, bool>> createUser({required User user});
}
