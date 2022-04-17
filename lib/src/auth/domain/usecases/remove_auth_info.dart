import 'package:whallet/src/auth/domain/repositories/remove_auth_info_repository_interface.dart';

abstract class IRemoveAuthInfo {
  Future<void> removeAuthInfo();
}

class RemoveAuthInfo implements IRemoveAuthInfo {
  IRemoveAuthInfoRepository iRemoveAuthInfoRepository;

  RemoveAuthInfo({required this.iRemoveAuthInfoRepository});
  @override
  Future<void> removeAuthInfo() async {
    return await iRemoveAuthInfoRepository.removeAuthInfo();
  }
}
