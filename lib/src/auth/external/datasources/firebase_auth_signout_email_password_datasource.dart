import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthSignOutEmailPasswordDatasource {
  final FirebaseAuth firebaseAuth;

  FirebaseAuthSignOutEmailPasswordDatasource({required this.firebaseAuth});

  Future<void> signout() async {
    return await firebaseAuth.signOut();
  }
}
