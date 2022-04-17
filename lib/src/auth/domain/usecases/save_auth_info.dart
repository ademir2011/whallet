import 'package:shared_preferences/shared_preferences.dart';
import 'package:whallet/src/auth/domain/entities/user_entity.dart';
import 'package:whallet/src/auth/domain/repositories/save_auth_info_repository_interface.dart';

abstract class ISaveAuthInfo {
  Future<void> saveAuthInfo({required UserEntity userEntity});
}

class SaveAuthInfo implements ISaveAuthInfo {
  final ISaveAuthInfoRepository iSaveAuthInfoRepository;

  SaveAuthInfo({
    required this.iSaveAuthInfoRepository,
  });

  @override
  Future<void> saveAuthInfo({required UserEntity userEntity}) async {
    return await iSaveAuthInfoRepository.saveAuthInfo(userEntity: userEntity);
  }
}
