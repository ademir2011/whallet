import 'package:firebase_auth/firebase_auth.dart';
import 'package:whallet/src/auth/models/user_model.dart';

class FirebaseAuthEmailPasswordDatasource {
  final instance = FirebaseAuth.instance;

  Future<UserCredential> signUp(UserModel userModel) {
    return instance.createUserWithEmailAndPassword(email: userModel.email, password: userModel.password);
  }

  Future<UserCredential> signIn(UserModel userModel) {
    return instance.signInWithEmailAndPassword(email: userModel.email, password: userModel.password);
  }

  Future logout() {
    return instance.signOut();
  }
}