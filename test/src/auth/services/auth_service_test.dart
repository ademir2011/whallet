import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:whallet/src/auth/models/user_model.dart';

void main() {
  late String login;
  late String password;
  late UserModel userModel;
  late MockFirebaseAuth auth;

  setUpAll(() {
    login = 'teste@teste.com';
    password = '123456';

    auth = MockFirebaseAuth(
      mockUser: MockUser(uid: '23123!@#!2', displayName: 'Ademir', email: login),
    );

    userModel = UserModel(login: login, password: password, email: login, uid: '', docRef: '');
  });

  test('Login com e-mail e senha', () async {
    final resultUserModel = await auth.signInWithEmailAndPassword(email: userModel.email, password: userModel.password);
    expect(resultUserModel.user, isNotNull);
    expect(resultUserModel.user!.uid, isNotEmpty);
  });
}
