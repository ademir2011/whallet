import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whallet/src/auth/bloc/auth_event.dart';
import 'package:whallet/src/auth/bloc/auth_state.dart';
import 'package:whallet/src/auth/enums/type_auth_enum.dart';
import 'package:whallet/src/auth/models/user_model.dart';
import 'package:whallet/src/auth/repositories/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({
    required this.authRepository,
  }) : super(AuthInitialState()) {
    on<AuthSignInEvent>(_signIn);
    on<AuthSignUpEvent>(_signUp);
    on<AuthSignOutEvent>(_signOut);
    on<AuthSaveCredentialEvent>(_authSaveCredentialEvent);
    on<AuthRemoveCredentialEvent>(_authRemoveCredentialEvent);
    on<CheckDataCredentialEvent>(_checkDataCredentialEvent);
  }

  Future<void> _authSaveCredentialEvent(AuthSaveCredentialEvent event, emit) async {
    emit(LoadingCheckCredentialAuthState());
    final prefs = await SharedPreferences.getInstance();
    if (event.email.isNotEmpty && event.password.isNotEmpty) {
      await prefs.setString('email', event.email);
      await prefs.setString('password', event.password);
    }
    emit(SuccessCredentialAuthState(checkDataCredential: true));
  }

  Future<void> _authRemoveCredentialEvent(event, emit) async {
    emit(LoadingCheckCredentialAuthState());
    final prefs = await SharedPreferences.getInstance();
    final emailRemoved = await prefs.remove('email');
    final passwordRemoved = await prefs.remove('password');
    if (emailRemoved && passwordRemoved) {
      emit(SuccessCredentialAuthState());
    } else {
      emit(ErrorAuthState(message: 'Não foi possível remover dados'));
    }
  }

  Future<void> _checkDataCredentialEvent(event, emit) async {
    emit(LoadingCheckCredentialAuthState());
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');
    final password = prefs.getString('password');
    if (email != null && password != null) {
      emit(SuccessCredentialAuthState(checkDataCredential: true, email: email, password: password));
    } else {
      emit(SuccessCredentialAuthState(checkDataCredential: false));
    }
  }

  _signIn(AuthSignInEvent event, emit) async {
    emit(LoadingAuthState());
    try {
      final userModel = UserModel.empty().copyWith(email: event.email, password: event.password);
      await authRepository.signIn(userModel: userModel, typeAuthEnum: TypeAuthEnum.emailPassword);
      emit(SuccessAuthState());
    } catch (e) {
      emit(ErrorAuthState(message: 'Falha na autenticação.'));
    }
  }

  Future<void> _signUp(AuthSignUpEvent event, emit) async {
    emit(LoadingAuthState());
    try {
      if (event.password != event.confirmPassword) {
        emit(ErrorAuthState(message: 'Senha difere da confirmação da senha'));
      }
      final userModel = UserModel.empty().copyWith(email: event.email, password: event.password);
      await authRepository.signUp(userModel: userModel, typeAuthEnum: TypeAuthEnum.emailPassword);
      emit(SuccessAuthState());
    } catch (e) {
      emit(ErrorAuthState(message: 'Houve um erro ao cadastrar ${e.toString()}'));
    }
  }

  _signOut(event, emit) {
    emit(LoadingAuthState());
    try {
      authRepository.logout(typeAuthEnum: TypeAuthEnum.emailPassword);
      emit(SuccessAuthState());
    } catch (e) {
      emit(ErrorAuthState(message: 'Erro ao deslogar'));
    }
  }
}
