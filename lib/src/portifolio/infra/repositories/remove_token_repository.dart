import 'package:whallet/src/portifolio/domain/entities/token_entity.dart';
import 'package:whallet/src/portifolio/domain/repositories/remove_token_repository_interface.dart';

class RemoveTokenRepository implements IRemoveTokenRepository {
  @override
  Future<void> removeToken({required TokenEntity tokenEntity}) {
    // TODO: implement removeToken
    throw UnimplementedError();
  }
}
