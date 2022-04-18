import 'package:firebase_auth/firebase_auth.dart';
import 'package:whallet/src/auth/domain/entities/user_entity.dart';
import 'package:whallet/src/auth/domain/errors/signin_exception.dart';
import 'package:whallet/src/auth/domain/repositories/signin_repository_interface.dart';

abstract class ISignin {
  Future<UserCredential> call({required UserEntity userEntity});
}

class SignIn implements ISignin {
  final ISignInRepository iSignInRepository;

  SignIn({required this.iSignInRepository});

  @override
  Future<UserCredential> call({required UserEntity userEntity}) async {
    if (userEntity.email.isEmpty || userEntity.password.isEmpty) return throw SigninDataException();

    try {
      return await iSignInRepository.signin(userEntity: userEntity);
    } catch (e) {
      return throw SigninError();
    }
  }
}
