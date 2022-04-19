import 'package:whallet/src/portifolio/domain/entities/token_entity.dart';
import 'package:whallet/src/portifolio/domain/repositories/get_token_info_by_token_repository_interface.dart';

abstract class IGetTokenInfoByToken {
  Future<TokenEntity> getTokenInfoByToken({required TokenEntity tokenEntity});
}

class GetTokenInfoByToken implements IGetTokenInfoByToken {
  final IGetTokenInfoByTokenRepository iGetTokenInfoByTokenRepository;

  GetTokenInfoByToken({required this.iGetTokenInfoByTokenRepository});

  @override
  Future<TokenEntity> getTokenInfoByToken({required TokenEntity tokenEntity}) async {
    return await iGetTokenInfoByTokenRepository.getTokenInfoByToken(tokenEntity: tokenEntity);
  }
}
