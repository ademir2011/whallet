import 'package:firebase_auth/firebase_auth.dart';
import 'package:whallet/src/auth/datasources/firebase_auth_email_password_datasource.dart';
import 'package:whallet/src/auth/enums/type_auth_enum.dart';
import 'package:whallet/src/auth/models/user_model.dart';

class AuthRepository {
  final FirebaseAuthEmailPasswordDatasource firebaseAuthEmailPasswordDatasource;

  AuthRepository({required this.firebaseAuthEmailPasswordDatasource});

  Future<UserCredential> signUp({required UserModel userModel, required TypeAuthEnum typeAuthEnum}) {
    if (typeAuthEnum == TypeAuthEnum.emailPassword) {
      return firebaseAuthEmailPasswordDatasource.signUp(userModel: userModel);
    } else if (typeAuthEnum == TypeAuthEnum.google) {
    } else if (typeAuthEnum == TypeAuthEnum.facebook) {
    } else if (typeAuthEnum == TypeAuthEnum.twitter) {}

    return Future.error(Exception);
  }

  Future<UserCredential> signIn({required UserModel userModel, required TypeAuthEnum typeAuthEnum}) {
    if (typeAuthEnum == TypeAuthEnum.emailPassword) {
      return firebaseAuthEmailPasswordDatasource.signIn(userModel: userModel);
    } else if (typeAuthEnum == TypeAuthEnum.google) {
    } else if (typeAuthEnum == TypeAuthEnum.facebook) {
    } else if (typeAuthEnum == TypeAuthEnum.twitter) {}
    return Future.error(Exception);
  }

  Future<void> logout({required TypeAuthEnum typeAuthEnum}) {
    if (typeAuthEnum == TypeAuthEnum.emailPassword) {
      return firebaseAuthEmailPasswordDatasource.logout();
    } else if (typeAuthEnum == TypeAuthEnum.google) {
    } else if (typeAuthEnum == TypeAuthEnum.facebook) {
    } else if (typeAuthEnum == TypeAuthEnum.twitter) {}
    return Future.error(Exception);
  }
}
