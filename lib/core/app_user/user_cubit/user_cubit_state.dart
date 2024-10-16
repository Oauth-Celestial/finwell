// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_cubit_cubit.dart';

enum UserStatus { loggedin, loggedout, loading }

class UserCubitState extends Equatable {
  UserStatus? status;
  AppUserModel? userData;
  UserCubitState({
    this.status,
    this.userData,
  });

  @override
  List<Object?> get props => [status, userData];

  static UserCubitState initial() {
    return UserCubitState(status: UserStatus.loggedout, userData: null);
  }

  UserCubitState copyWith({
    UserStatus? status,
    AppUserModel? userData,
  }) {
    return UserCubitState(
      status: status ?? this.status,
      userData: userData ?? this.userData,
    );
  }
}
