import 'package:whallet/src/auth/domain/entities/user_entity.dart';

abstract class ISaveAuthInfoRepository {
  Future<void> saveAuthInfo({required UserEntity userEntity});
}
