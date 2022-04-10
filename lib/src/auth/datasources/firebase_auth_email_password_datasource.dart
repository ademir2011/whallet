import 'package:firebase_auth/firebase_auth.dart';
import 'package:whallet/src/auth/models/user_model.dart';

class FirebaseAuthEmailPasswordDatasource {
  final FirebaseAuth firebaseAuth;

  FirebaseAuthEmailPasswordDatasource({required this.firebaseAuth});

  Future<UserCredential> signUp({required UserModel userModel}) async {
    final UserCredential userCredential;
    if (firebaseAuth.currentUser == null) {
      userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(email: userModel.email, password: userModel.password);
    } else {
      logout();
      return Future.error(Exception('Possivelmente você realizou um cadastro recentemente.'));
    }
    return userCredential;
  }

  Future<UserCredential> signIn({required UserModel userModel}) {
    return firebaseAuth.signInWithEmailAndPassword(email: userModel.email, password: userModel.password);
  }

  Future logout() {
    return firebaseAuth.signOut();
  }
}
