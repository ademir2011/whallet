import 'package:whallet/src/portifolio/domain/entities/token_entity.dart';
import 'package:whallet/src/portifolio/domain/repositories/remove_token_repository_interface.dart';

abstract class IRemoveToken {
  Future<void> removeToken({required TokenEntity tokenEntity});
}

class RemoveToken implements IRemoveToken {
  final IRemoveTokenRepository iRemoveTokenRepository;

  RemoveToken({required this.iRemoveTokenRepository});

  @override
  Future<void> removeToken({required TokenEntity tokenEntity}) async {
    return await iRemoveTokenRepository.removeToken(tokenEntity: tokenEntity);
  }
}
