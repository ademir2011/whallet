import 'package:shared_preferences/shared_preferences.dart';
import 'package:whallet/src/auth/domain/entities/user_entity.dart';
import 'package:whallet/src/auth/infra/datasources/check_auth_datasource.dart';
import 'package:whallet/src/auth/infra/models/user_model.dart';

class CheckAuthDatasource implements ICheckAuthDatasource {
  @override
  Future<UserModel?> checkAuth() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');
    final password = prefs.getString('password');

    if (email != null && password != null) {
      return UserModel.empty().copyWith(email: email, password: password);
    }
    return null;
  }
}
