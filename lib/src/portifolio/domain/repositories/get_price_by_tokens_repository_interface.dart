import 'package:whallet/src/portifolio/domain/entities/token_entity.dart';

abstract class IGetPriceByTokensRepository {
  Future<List<TokenEntity>> getPriceByTokens({required List<TokenEntity> tokensEntity});
}
