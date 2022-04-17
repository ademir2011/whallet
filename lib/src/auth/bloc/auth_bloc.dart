import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whallet/src/auth/bloc/auth_event.dart';
import 'package:whallet/src/auth/bloc/auth_state.dart';
import 'package:whallet/src/auth/domain/usecases/check_auth.dart';
import 'package:whallet/src/auth/domain/usecases/remove_auth_info.dart';
import 'package:whallet/src/auth/domain/usecases/save_auth_info.dart';
import 'package:whallet/src/auth/domain/usecases/signin.dart';
import 'package:whallet/src/auth/domain/usecases/signout.dart';
import 'package:whallet/src/auth/domain/usecases/signup.dart';
import 'package:whallet/src/auth/infra/models/user_model.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUp signUp;
  final SignIn signIn;
  final SignOut signOut;
  final SaveAuthInfo saveAuthInfo;
  final RemoveAuthInfo removeAuthInfo;
  final CheckAuth checkAuth;

  AuthBloc({
    required this.signUp,
    required this.signIn,
    required this.signOut,
    required this.saveAuthInfo,
    required this.removeAuthInfo,
    required this.checkAuth,
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
    try {
      await saveAuthInfo.saveAuthInfo(
        userEntity: UserModel.empty().copyWith(
          email: event.email,
          password: event.password,
        ),
      );

      emit(SuccessCredentialAuthState(checkDataCredential: true));
    } catch (e) {
      emit(ErrorAuthState(message: 'Não foi possível salvar credenciais'));
    }
  }

  Future<void> _authRemoveCredentialEvent(event, emit) async {
    emit(LoadingCheckCredentialAuthState());
    try {
      await removeAuthInfo.removeAuthInfo();
      emit(SuccessCredentialAuthState());
    } catch (e) {
      emit(ErrorAuthState(message: 'Não foi possível remover dados'));
    }
  }

  Future<void> _checkDataCredentialEvent(event, emit) async {
    emit(LoadingCheckCredentialAuthState());
    try {
      final userModel = await checkAuth.checkAuth();
      if (userModel != null) {
        emit(SuccessCredentialAuthState(
            checkDataCredential: true, email: userModel.email, password: userModel.password));
      } else {
        emit(SuccessCredentialAuthState(checkDataCredential: false));
      }
    } catch (e) {
      emit(ErrorAuthState(message: 'Erro ao recuperar dados salvos'));
    }
  }

  _signIn(AuthSignInEvent event, emit) async {
    emit(LoadingAuthState());
    try {
      final userEntity = UserModel.empty().copyWith(email: event.email, password: event.password);
      await signIn(userEntity: userEntity);
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
      final userEntity = UserModel.empty().copyWith(email: event.email, password: event.password);
      await signUp(userEntity: userEntity);
      emit(SuccessAuthState());
    } catch (e) {
      emit(ErrorAuthState(message: 'Houve um erro ao cadastrar ${e.toString()}'));
    }
  }

  _signOut(event, emit) {
    emit(LoadingAuthState());
    try {
      signOut();
      emit(SuccessAuthState());
    } catch (e) {
      emit(ErrorAuthState(message: 'Erro ao deslogar'));
    }
  }
}
