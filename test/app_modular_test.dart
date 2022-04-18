import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';
import 'package:whallet/app_modular.dart';
import 'package:whallet/src/auth/domain/usecases/signin.dart';

class FirebaseAuthMock extends Mock implements FirebaseAuth {}

void main() {
  final firebaseAuthMock = FirebaseAuthMock();

  setUp(() {
    initModule(AppModule(), replaceBinds: [
      Bind.singleton<FirebaseAuth>((i) => firebaseAuthMock),
    ]);
  });

  test('Testando instâncias do module', () {
    expect(Modular.get<SignIn>(), isA<SignIn>());
  });
}
