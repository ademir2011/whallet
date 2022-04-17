import 'package:firebase_auth/firebase_auth.dart';
import 'package:whallet/src/auth/domain/entities/user_entity.dart';
import 'package:whallet/src/auth/infra/models/user_model.dart';

abstract class SignInDatasource {
  Future<UserCredential> signin({required UserEntity userEntity});
}
