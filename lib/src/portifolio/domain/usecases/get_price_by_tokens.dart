import 'package:whallet/src/portifolio/domain/entities/token_entity.dart';
import 'package:whallet/src/portifolio/domain/repositories/get_price_by_tokens_repository_interface.dart';

abstract class IGetPriceByTokens {
  Future<List<TokenEntity>> getPriceByTokens({required List<TokenEntity> tokensEntity});
}

class GetPriceByTokens implements IGetPriceByTokens {
  final IGetPriceByTokensRepository iGetPriceByTokensRepository;

  GetPriceByTokens({required this.iGetPriceByTokensRepository});

  @override
  Future<List<TokenEntity>> getPriceByTokens({required List<TokenEntity> tokensEntity}) async {
    return await iGetPriceByTokensRepository.getPriceByTokens(tokensEntity: tokensEntity);
  }
}
