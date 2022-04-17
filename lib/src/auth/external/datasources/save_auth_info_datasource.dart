import 'package:shared_preferences/shared_preferences.dart';
import 'package:whallet/src/auth/domain/entities/user_entity.dart';
import 'package:whallet/src/auth/infra/datasources/save_auth_info_datasource.dart';

class SaveAuthInfoDatasource implements ISaveAuthInfoDatasource {
  @override
  Future<void> saveAuthInfo({required UserEntity userEntity}) async {
    final prefs = await SharedPreferences.getInstance();
    if (userEntity.email.isNotEmpty && userEntity.password.isNotEmpty) {
      await prefs.setString('email', userEntity.email);
      await prefs.setString('password', userEntity.password);
    }
  }
}
