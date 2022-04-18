import 'package:firebase_auth/firebase_auth.dart';
import 'package:whallet/src/auth/domain/entities/user_entity.dart';

abstract class ISignUpDatasource {
  Future<UserCredential> signup({required UserEntity userEntity});
}
