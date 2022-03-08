import 'package:flutter_test/flutter_test.dart';
import 'package:whallet/src/auth/models/user_model.dart';

void main() {
  test(
    'Não deve aceitar login com menos que 6 caracteres',
    () {
      expect(() => UserModel(login: 'abcde', password: '123456', email: 'test@teste.com', uid: '', docRef: ''),
          throwsAssertionError);
    },
  );

  test(
    'Não deve aceitar senha com menos que 6 caracteres',
    () {
      expect(() => UserModel(login: 'asdasdasd', password: '12345', email: 'test@teste.com', uid: '', docRef: ''),
          throwsAssertionError);
    },
  );

  test(
    'Deve aceitar login e senha com 6 caracteres',
    () {
      expect(() => UserModel(login: 'asdasd', password: '123456', email: 'test@teste.com', uid: '', docRef: ''),
          isNot(throwsAssertionError));
    },
  );

  test(
    'Não deve aceitar e-mail inválido xxx@xxx',
    () {
      expect(() => UserModel(login: 'asasdasdasd', password: '12345674744', email: 'teste.com', uid: '', docRef: ''),
          throwsAssertionError);
    },
  );
}
