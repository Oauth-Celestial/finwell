part of 'auth_bloc.dart';

enum AuthStatus { initial, loading, failure, success }

class AuthState extends Equatable {
  AuthStatus status;
  User? currentUser;
  AppUserModel? userData;
  AuthState({required this.status, this.currentUser, this.userData});

  static AuthState initial() {
    return AuthState(status: AuthStatus.initial);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [status, currentUser, userData];

  AuthState copyWith(
      {AuthStatus? status, User? currentUser, AppUserModel? userData}) {
    return AuthState(
        status: status ?? this.status,
        currentUser: currentUser ?? this.currentUser,
        userData: userData ?? this.userData);
  }
}
