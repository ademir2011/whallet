import 'package:whallet/src/auth/infra/models/user_model.dart';

abstract class ICheckAuthRepository {
  Future<UserModel?> checkAuth();
}
