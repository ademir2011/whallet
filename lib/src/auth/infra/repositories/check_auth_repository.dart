import 'package:whallet/src/auth/domain/usecases/check_auth.dart';
import 'package:whallet/src/auth/infra/datasources/check_auth_datasource.dart';
import 'package:whallet/src/auth/infra/models/user_model.dart';

class CheckAuth implements ICheckAuth {
  final ICheckAuthDatasource iCheckAuthDatasource;

  CheckAuth({required this.iCheckAuthDatasource});

  @override
  Future<UserModel?> checkAuth() async {
    return await iCheckAuthDatasource.checkAuth();
  }
}
