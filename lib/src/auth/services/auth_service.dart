import 'package:firebase_auth/firebase_auth.dart';
import 'package:whallet/src/auth/enums/type_auth_enum.dart';
import 'package:whallet/src/auth/models/user_model.dart';
import 'package:whallet/src/auth/repositories/auth_repository.dart';

class AuthService {
  final authRepository = AuthRepository();

  Future<UserModel> signUp({required UserModel userModel, required TypeAuthEnum typeAuthEnum}) async {
    UserCredential userCredential = await authRepository.signUp(userModel: userModel, typeAuthEnum: typeAuthEnum);
    return userModel.copyWith(uid: userCredential.user!.uid);
  }

  Future<UserModel> signIn({required UserModel userModel, required TypeAuthEnum typeAuthEnum}) async {
    UserCredential userCredential = await authRepository.signIn(userModel: userModel, typeAuthEnum: typeAuthEnum);
    return userModel;
  }

  Future<void> logout({required TypeAuthEnum typeAuthEnum}) async {
    return await authRepository.logout(typeAuthEnum: typeAuthEnum);
  }
}
