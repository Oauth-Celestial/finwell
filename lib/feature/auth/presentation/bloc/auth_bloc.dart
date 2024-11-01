import 'package:equatable/equatable.dart';
import 'package:finwell/core/app_user/model/app_user_model.dart';
import 'package:finwell/core/usecase/use_cases.dart';
import 'package:finwell/feature/auth/domain/usecase/create_user_use_case.dart';
import 'package:finwell/feature/auth/domain/usecase/google_login_use_case.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GoogleLoginUseCase _googleLoginUseCase;
  final CreateUserUseCase _createUserUseCase;
  AuthBloc(
      {required GoogleLoginUseCase googleLoginUseCase,
      required CreateUserUseCase createUserUseCase})
      : _googleLoginUseCase = googleLoginUseCase,
        _createUserUseCase = createUserUseCase,
        super(AuthState.initial()) {
    on<AuthLoginWithGoogle>(_handleGoogleLogin);
    on<AuthLoggedInUser>(_handleLoggedInUser);
  }

  void _handleGoogleLogin(
      AuthLoginWithGoogle event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final result = await _googleLoginUseCase(NoParamsType());
      await result.fold((failure) {
        emit(state.copyWith(status: AuthStatus.failure));
      }, (user) async {
        final hascreatedUser = await _createUserUseCase(user);
        hascreatedUser.fold((failure) {
          emit(state.copyWith(status: AuthStatus.failure));
        }, (success) {
          emit(state.copyWith(
            currentUser: user,
            status: AuthStatus.success,
          ));
        });
      });
    } catch (e) {}
  }

  void _handleLoggedInUser(AuthLoggedInUser event, Emitter<AuthState> emit) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      emit(state.copyWith(
        currentUser: user,
        status: AuthStatus.success,
      ));
    }
  }
}
