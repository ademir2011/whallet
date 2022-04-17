import 'package:whallet/src/auth/domain/entities/user_entity.dart';
import 'package:whallet/src/auth/domain/repositories/save_auth_info_repository_interface.dart';
import 'package:whallet/src/auth/infra/datasources/save_auth_info_datasource.dart';

class SaveAuthInfoRepository implements ISaveAuthInfoRepository {
  final ISaveAuthInfoDatasource iSaveAuthInfoDatasource;

  SaveAuthInfoRepository({required this.iSaveAuthInfoDatasource});

  @override
  Future<void> saveAuthInfo({required UserEntity userEntity}) async {
    return await iSaveAuthInfoDatasource.saveAuthInfo(userEntity: userEntity);
  }
}
