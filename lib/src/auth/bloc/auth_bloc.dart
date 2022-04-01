import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whallet/src/auth/bloc/auth_event.dart';
import 'package:whallet/src/auth/bloc/auth_state.dart';
import 'package:whallet/src/auth/enums/type_auth_enum.dart';
import 'package:whallet/src/auth/models/user_model.dart';
import 'package:whallet/src/auth/services/auth_service.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;

  AuthBloc({
    required this.authService,
  }) : super(AuthInitialState()) {
    on<AuthSignInEvent>(_signIn);
    on<AuthSignUpEvent>(_signUp);
    on<AuthSignOutEvent>(_signOut);
  }

  _signIn(AuthSignInEvent event, emit) async {
    emit(LoadingAuthState());
    try {
      // await authService.signIn(userModel: event.userModel, typeAuthEnum: TypeAuthEnum.emailPassword);
      await Future.delayed(const Duration(seconds: 3));
      emit(SucessAuthState());
    } catch (e) {
      emit(ErrorAuthState());
    }
  }

  Future<void> _signUp(AuthSignUpEvent event, emit) async {
    emit(LoadingAuthState());
    try {
      await authService.signUp(userModel: event.userModel, typeAuthEnum: TypeAuthEnum.emailPassword);
    } catch (e) {
      emit(ErrorAuthState());
    }
  }

  _signOut(event, emit) {}
}
