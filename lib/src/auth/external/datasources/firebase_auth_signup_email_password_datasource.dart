import 'package:firebase_auth/firebase_auth.dart';
import 'package:whallet/src/auth/domain/entities/user_entity.dart';
import 'package:whallet/src/auth/external/datasources/firebase_auth_signout_email_password_datasource.dart';
import 'package:whallet/src/auth/infra/datasources/signup_datasource.dart';

class FirebaseAuthSignUpEmailPasswordDatasource implements ISignUpDatasource {
  final FirebaseAuth firebaseAuth;
  final FirebaseAuthSignOutEmailPasswordDatasource firebaseAuthSignOutEmailPasswordDatasource;

  FirebaseAuthSignUpEmailPasswordDatasource({
    required this.firebaseAuth,
    required this.firebaseAuthSignOutEmailPasswordDatasource,
  });

  @override
  Future<UserCredential> signup({required UserEntity userEntity}) async {
    final UserCredential userCredential;
    if (firebaseAuth.currentUser == null) {
      userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(email: userEntity.email, password: userEntity.password);
    } else {
      firebaseAuthSignOutEmailPasswordDatasource.signout();
      return Future.error(Exception('Possivelmente você realizou um cadastro recentemente.'));
    }
    return userCredential;
  }
}
