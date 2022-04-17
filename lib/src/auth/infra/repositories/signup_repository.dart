import 'package:whallet/src/auth/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whallet/src/auth/domain/errors/signup_exception.dart';
import 'package:whallet/src/auth/domain/repositories/signup_repository_interface.dart';
import 'package:whallet/src/auth/infra/datasources/signup_datasource.dart';
import 'package:whallet/src/auth/infra/models/user_model.dart';

class SignUpRepository implements ISignUpRepository {
  final SignUpDatasource signUpDatasource;

  SignUpRepository({required this.signUpDatasource});

  @override
  Future<UserCredential> signup({required UserEntity userEntity}) async {
    try {
      return await signUpDatasource.signup(userEntity: userEntity);
    } catch (e) {
      throw Exception();
    }
  }
}
