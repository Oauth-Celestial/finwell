part of 'auth_bloc.dart';

enum AuthStatus { initial, loading, failure, success }

class AuthState extends Equatable {
  AuthStatus status;
  User? currentUser;
  AuthState({
    required this.status,
    this.currentUser,
  });

  static AuthState initial() {
    return AuthState(status: AuthStatus.initial);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [status, currentUser];

  AuthState copyWith({
    AuthStatus? status,
    User? currentUser,
  }) {
    return AuthState(
      status: status ?? this.status,
      currentUser: currentUser ?? this.currentUser,
    );
  }
}
