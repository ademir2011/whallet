import 'package:whallet/src/portifolio/domain/entities/token_entity.dart';

abstract class IGetTokenInfoByTokenRepository {
  Future<TokenEntity> getTokenInfoByToken({required TokenEntity tokenEntity});
}
