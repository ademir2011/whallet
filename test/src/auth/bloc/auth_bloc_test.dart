import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:whallet/src/auth/bloc/auth_bloc.dart';
import 'package:whallet/src/auth/bloc/auth_event.dart';
import 'package:whallet/src/auth/bloc/auth_state.dart';
import 'package:whallet/src/auth/external/datasources/firebase_auth_signin_email_password_datasource.dart';
import 'package:whallet/src/auth/enums/type_auth_enum.dart';
import 'package:whallet/src/auth/domain/entities/user_entity.dart';
import 'package:whallet/src/auth/repositories/auth_repository.dart';

class UserCredentialMock extends Mock implements UserCredential {}

class FirebaseAuthMock extends Mock implements FirebaseAuth {}

void main() {
  blocTest<AuthBloc, AuthState>(
    'Deve realizar o cadastro corretamente',
    build: () {
      final firebaseAuthMock = FirebaseAuthMock();

      when(
        () => firebaseAuthMock.createUserWithEmailAndPassword(
          email: any<String>(named: 'email'),
          password: any<String>(named: 'password'),
        ),
      ).thenAnswer((_) async => UserCredentialMock());

      return AuthBloc(
        authRepository: AuthRepository(
          firebaseAuthEmailPasswordDatasource: FirebaseAuthEmailPasswordDatasource(firebaseAuth: firebaseAuthMock),
        ),
      );
    },
    act: (bloc) => bloc.add(AuthSignUpEvent(email: 'teste@teste.com', password: '123456', confirmPassword: '123456')),
    wait: const Duration(seconds: 1),
    expect: () => [
      isA<LoadingAuthState>(),
      isA<SuccessAuthState>(),
    ],
  );

  blocTest<AuthBloc, AuthState>(
    'Deve executar um erro realizar o cadastro',
    build: () {
      registerFallbackValue(UserModel.empty());
      registerFallbackValue(TypeAuthEnum.emailPassword);

      final firebaseAuthMock = FirebaseAuthMock();
      when(
        () => firebaseAuthMock.createUserWithEmailAndPassword(
          email: any<String>(named: 'email'),
          password: any<String>(named: 'password'),
        ),
      ).thenThrow(Exception());

      return AuthBloc(
        authRepository: AuthRepository(
          firebaseAuthEmailPasswordDatasource: FirebaseAuthEmailPasswordDatasource(firebaseAuth: firebaseAuthMock),
        ),
      );
    },
    act: (bloc) => bloc.add(AuthSignUpEvent(email: 'teste@teste.com', password: '123456', confirmPassword: '123456')),
    wait: const Duration(seconds: 1),
    expect: () => [
      isA<LoadingAuthState>(),
      isA<ErrorAuthState>(),
    ],
  );

  blocTest<AuthBloc, AuthState>(
    'Deve realizar login com sucesso',
    build: () {
      final firebaseAuthMock = FirebaseAuthMock();

      when(
        () => firebaseAuthMock.createUserWithEmailAndPassword(
          email: any<String>(named: 'email'),
          password: any<String>(named: 'password'),
        ),
      ).thenAnswer((_) async => UserCredentialMock());

      return AuthBloc(
        authRepository: AuthRepository(
          firebaseAuthEmailPasswordDatasource: FirebaseAuthEmailPasswordDatasource(firebaseAuth: firebaseAuthMock),
        ),
      );
    },
    act: (bloc) => bloc.add(AuthSignUpEvent(email: 'teste@teste.com', password: '123456', confirmPassword: '123456')),
    wait: const Duration(seconds: 1),
    expect: () => [
      isA<LoadingAuthState>(),
      isA<SuccessAuthState>(),
    ],
  );
}
