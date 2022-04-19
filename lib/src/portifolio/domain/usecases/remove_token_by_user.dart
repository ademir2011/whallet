import 'package:whallet/src/portifolio/domain/entities/token_entity.dart';
import 'package:whallet/src/portifolio/domain/repositories/remove_token_by_user_repository_interface.dart';

abstract class IRemoveTokenByUser {
  Future<void> removeTokenByUser({required TokenEntity tokenEntity});
}

class RemoveTokenByUser implements IRemoveTokenByUser {
  final IRemoveTokenByUserRepository iRemoveTokenByUserRepository;

  RemoveTokenByUser({required this.iRemoveTokenByUserRepository});

  @override
  Future<void> removeTokenByUser({required TokenEntity tokenEntity}) async {
    return await iRemoveTokenByUserRepository.removeTokenByUser(tokenEntity: tokenEntity);
  }
}
