import 'package:firebase_auth/firebase_auth.dart';
import 'package:whallet/src/auth/domain/entities/user_entity.dart';
import 'package:whallet/src/auth/domain/errors/signup_exception.dart';
import 'package:whallet/src/auth/domain/repositories/signup_repository_interface.dart';

abstract class ISignUp {
  Future<UserCredential> call({required UserEntity userEntity});
}

class SignUp implements ISignUp {
  final ISignUpRepository iSignUpRepository;

  SignUp({required this.iSignUpRepository});

  @override
  Future<UserCredential> call({required UserEntity userEntity}) async {
    if (userEntity.email.isEmpty || userEntity.password.isEmpty) return throw SignUpDataException();

    try {
      return await iSignUpRepository.signup(userEntity: userEntity);
    } catch (e) {
      throw SignUpErrorException();
    }
  }
}
