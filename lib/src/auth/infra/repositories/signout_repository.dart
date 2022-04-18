import 'package:whallet/src/auth/domain/repositories/signout_repository_interface.dart';
import 'package:whallet/src/auth/infra/datasources/signout_datasource.dart';

class SignOutRepository implements ISignOutRepository {
  final ISignOutDatasource iSignOutDatasource;

  SignOutRepository({required this.iSignOutDatasource});

  @override
  Future<void> signOut() async {
    try {
      return await iSignOutDatasource.signout();
    } catch (e) {
      throw Exception();
    }
  }
}
