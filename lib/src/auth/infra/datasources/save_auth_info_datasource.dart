import 'package:whallet/src/auth/domain/entities/user_entity.dart';

abstract class ISaveAuthInfoDatasource {
  Future<void> saveAuthInfo({required UserEntity userEntity});
}
