import 'package:firebase_auth/firebase_auth.dart';
import 'package:whallet/src/auth/domain/entities/user_entity.dart';
import 'package:whallet/src/auth/infra/datasources/signin_datasource.dart';

class FirebaseAuthSignInEmailPasswordDatasource implements ISignInDatasource {
  final FirebaseAuth firebaseAuth;

  FirebaseAuthSignInEmailPasswordDatasource({required this.firebaseAuth});

  @override
  Future<UserCredential> signin({required UserEntity userEntity}) {
    return firebaseAuth.signInWithEmailAndPassword(email: userEntity.email, password: userEntity.password);
  }
}
