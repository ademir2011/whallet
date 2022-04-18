import 'package:whallet/src/portifolio/domain/entities/token_entity.dart';

abstract class IFetchDetailTokenRepository {
  Future<TokenEntity> fetchDetailToken({required TokenEntity tokenEntity});
}
