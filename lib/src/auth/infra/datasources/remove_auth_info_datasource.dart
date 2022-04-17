import 'package:whallet/src/auth/domain/entities/user_entity.dart';

abstract class IRemoveAuthInfoDatasource {
  Future<void> removeAuthInfoDatasource();
}
