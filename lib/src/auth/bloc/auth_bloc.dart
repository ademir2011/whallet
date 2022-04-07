import 'package:flutter_bloc/flutter_bloc.dart';
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

  _signOut(event, emit) {}
}
