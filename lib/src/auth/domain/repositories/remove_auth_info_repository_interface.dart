import 'package:whallet/src/auth/domain/entities/user_entity.dart';

abstract class IRemoveAuthInfoRepository {
  Future<void> removeAuthInfo();
}
