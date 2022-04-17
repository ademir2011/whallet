import 'package:firebase_auth/firebase_auth.dart';
import 'package:whallet/src/auth/domain/entities/user_entity.dart';

abstract class ISignInRepository {
  Future<UserCredential> signin({required UserEntity userEntity});
}
