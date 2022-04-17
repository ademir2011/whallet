import 'package:firebase_auth/firebase_auth.dart';
import 'package:whallet/src/auth/domain/entities/user_entity.dart';

class FirebaseAuthSignInEmailPasswordDatasource {
  final FirebaseAuth firebaseAuth;

  FirebaseAuthSignInEmailPasswordDatasource({required this.firebaseAuth});

  Future<UserCredential> signIn({required UserEntity userEntity}) {
    return firebaseAuth.signInWithEmailAndPassword(email: userEntity.email, password: userEntity.password);
  }
}
