import 'package:firebase_auth/firebase_auth.dart';
import 'package:whallet/src/auth/infra/datasources/signout_datasource.dart';

class FirebaseAuthSignOutEmailPasswordDatasource implements ISignOutDatasource {
  final FirebaseAuth firebaseAuth;

  FirebaseAuthSignOutEmailPasswordDatasource({required this.firebaseAuth});

  @override
  Future<void> signout() async {
    return await firebaseAuth.signOut();
  }
}
