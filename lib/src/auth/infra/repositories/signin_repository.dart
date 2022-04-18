import 'package:firebase_auth/firebase_auth.dart';
import 'package:whallet/src/auth/domain/entities/user_entity.dart';
import 'package:whallet/src/auth/domain/repositories/signin_repository_interface.dart';
import 'package:whallet/src/auth/infra/datasources/signin_datasource.dart';
import 'package:whallet/src/auth/infra/models/user_model.dart';

class SignInRepository implements ISignInRepository {
  final ISignInDatasource iSignInDatasource;

  SignInRepository({required this.iSignInDatasource});

  @override
  Future<UserCredential> signin({required UserEntity userEntity}) async {
    try {
      return await iSignInDatasource.signin(userEntity: userEntity);
    } catch (e) {
      throw Exception();
    }
  }
}
