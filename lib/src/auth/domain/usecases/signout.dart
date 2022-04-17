import 'package:whallet/src/auth/domain/errors/signout_exception.dart';
import 'package:whallet/src/auth/domain/repositories/signout_repository_interface.dart';

abstract class ISignOut {
  Future<void> call();
}

class SignOut implements ISignOut {
  final ISignOutRepository iSignOutRepository;

  SignOut({required this.iSignOutRepository});

  @override
  Future<void> call() async {
    try {
      await iSignOutRepository.signOut();
    } catch (e) {
      throw SignOutErrorException();
    }
  }
}
