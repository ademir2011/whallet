import 'package:whallet/src/auth/domain/repositories/check_auth_repository_interface.dart';
import 'package:whallet/src/auth/infra/models/user_model.dart';

abstract class ICheckAuth {
  Future<UserModel?> checkAuth();
}

class CheckAuth implements ICheckAuth {
  final ICheckAuthRepository iCheckAuthRepository;

  CheckAuth({required this.iCheckAuthRepository});

  @override
  Future<UserModel?> checkAuth() async {
    return await iCheckAuthRepository.checkAuth();
  }
}
