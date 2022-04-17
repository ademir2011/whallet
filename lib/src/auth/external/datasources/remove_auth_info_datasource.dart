import 'package:shared_preferences/shared_preferences.dart';
import 'package:whallet/src/auth/domain/entities/user_entity.dart';
import 'package:whallet/src/auth/infra/datasources/remove_auth_info_datasource.dart';

class RemoveAuthInfoDatasource implements IRemoveAuthInfoDatasource {
  @override
  Future<void> removeAuthInfoDatasource() async {
    final prefs = await SharedPreferences.getInstance();
    final emailRemoved = await prefs.remove('email');
    final passwordRemoved = await prefs.remove('password');
  }
}
