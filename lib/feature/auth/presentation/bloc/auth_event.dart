part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthLoginWithGoogle extends AuthEvent {}

class AuthLoggedInUser extends AuthEvent {}

class AuthLogoutUser extends AuthEvent {}
