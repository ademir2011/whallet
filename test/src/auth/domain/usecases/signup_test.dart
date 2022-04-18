import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';
import 'package:whallet/app_modular.dart';
import 'package:whallet/src/auth/domain/usecases/signup.dart';
import 'package:whallet/src/auth/infra/models/user_model.dart';

class FirebaseAuthMock extends Mock implements FirebaseAuth {}

class UserCredentialMock extends Mock implements UserCredential {}

void main() {
  final firebaseAuthMock = FirebaseAuthMock();
  final userCredetial = UserCredentialMock();
  setUp(() {
    initModule(AppModule(), replaceBinds: [
      Bind.singleton<FirebaseAuth>((i) => firebaseAuthMock),
    ]);
  });

  test('Deve realizar cadastro', () async {
    final signUp = Modular.get<SignUp>();

    when(
      () => firebaseAuthMock.createUserWithEmailAndPassword(
        email: any<String>(named: 'email'),
        password: any<String>(named: 'password'),
      ),
    ).thenAnswer((invocation) async => userCredetial);

    final userModel = UserModel.empty().copyWith(email: 'teste@teste.com', password: '123456');

    expect(await signUp(userEntity: userModel), isA<UserCredential>());
  });
}
