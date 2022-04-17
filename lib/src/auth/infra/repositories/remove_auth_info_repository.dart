import 'package:whallet/src/auth/domain/entities/user_entity.dart';
import 'package:whallet/src/auth/domain/repositories/remove_auth_info_repository_interface.dart';
import 'package:whallet/src/auth/infra/datasources/remove_auth_info_datasource.dart';

class RemoveAuthInfoRepository implements IRemoveAuthInfoRepository {
  final IRemoveAuthInfoDatasource iRemoveAuthInfoDatasource;

  RemoveAuthInfoRepository({required this.iRemoveAuthInfoDatasource});

  @override
  Future<void> removeAuthInfo() async {
    return await iRemoveAuthInfoDatasource.removeAuthInfoDatasource();
  }
}
