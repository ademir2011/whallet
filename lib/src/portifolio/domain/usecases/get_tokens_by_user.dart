import 'package:whallet/src/portifolio/domain/entities/token_entity.dart';
import 'package:whallet/src/portifolio/domain/repositories/get_tokens_by_user_repository_interface.dart';

abstract class IGetTokensByUser {
  Future<List<TokenEntity>> getTokensByUser();
}

class GetTokensByUser implements IGetTokensByUser {
  final IGetTokensByUserRepository iGetTokensByUserRepository;
  GetTokensByUser({required this.iGetTokensByUserRepository});
  @override
  Future<List<TokenEntity>> getTokensByUser() async {
    return await iGetTokensByUserRepository.getTokensByUser();
  }
}
