import 'package:whallet/src/auth/domain/repositories/signout_repository_interface.dart';
import 'package:whallet/src/auth/infra/datasources/signout_datasource.dart';

class SignOutRepository implements ISignOutRepository {
  final SignOutDatasource signOutDatasource;

  SignOutRepository({required this.signOutDatasource});

  @override
  Future<void> signOut() async {
    try {
      return await signOutDatasource.signout();
    } catch (e) {
      throw Exception();
    }
  }
}
