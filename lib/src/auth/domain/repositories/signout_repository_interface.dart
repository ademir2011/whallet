import 'package:whallet/src/auth/domain/entities/user_entity.dart';

abstract class ISignOutRepository {
  Future<void> signOut();
}
