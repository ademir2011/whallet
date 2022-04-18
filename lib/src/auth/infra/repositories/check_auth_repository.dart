import 'package:whallet/src/auth/domain/repositories/check_auth_repository_interface.dart';
import 'package:whallet/src/auth/domain/usecases/check_auth.dart';
import 'package:whallet/src/auth/infra/datasources/check_auth_datasource.dart';
import 'package:whallet/src/auth/infra/models/user_model.dart';

class CheckAuthRepository implements ICheckAuthRepository {
  final ICheckAuthDatasource iCheckAuthDatasource;

  CheckAuthRepository({required this.iCheckAuthDatasource});

  @override
  Future<UserModel?> checkAuth() async {
    return await iCheckAuthDatasource.checkAuth();
  }
}
