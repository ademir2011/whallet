import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';
import 'package:whallet/app_modular.dart';
import 'package:whallet/src/auth/bloc/auth_bloc.dart';
import 'package:whallet/src/auth/bloc/auth_event.dart';
import 'package:whallet/src/auth/bloc/auth_state.dart';

class UserCredentialMock extends Mock implements UserCredential {}

class FirebaseAuthMock extends Mock implements FirebaseAuth {}

void main() {
  final firebaseAuthMock = FirebaseAuthMock();
  late AuthBloc authBloc;

  setUp(() {
    Modular.destroy();
    initModule(AppModule(), replaceBinds: [
      Bind.singleton<FirebaseAuth>((i) => firebaseAuthMock),
    ]);
    authBloc = Modular.get<AuthBloc>();
  });

  blocTest<AuthBloc, AuthState>(
    'Deve realizar o cadastro corretamente',
    build: () {
      when(
        () => firebaseAuthMock.createUserWithEmailAndPassword(
          email: any<String>(named: 'email'),
          password: any<String>(named: 'password'),
        ),
      ).thenAnswer((_) async => UserCredentialMock());

      return authBloc;
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
      when(
        () => firebaseAuthMock.createUserWithEmailAndPassword(
          email: any<String>(named: 'email'),
          password: any<String>(named: 'password'),
        ),
      ).thenThrow(Exception());

      return authBloc;
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
      when(
        () => firebaseAuthMock.createUserWithEmailAndPassword(
          email: any<String>(named: 'email'),
          password: any<String>(named: 'password'),
        ),
      ).thenAnswer((_) async => UserCredentialMock());

      return authBloc;
    },
    act: (bloc) => bloc.add(AuthSignUpEvent(email: 'teste@teste.com', password: '123456', confirmPassword: '123456')),
    wait: const Duration(seconds: 1),
    expect: () => [
      isA<LoadingAuthState>(),
      isA<SuccessAuthState>(),
    ],
  );
}
