import 'package:whallet/src/portifolio/domain/entities/token_entity.dart';

abstract class IFetchTokensDatasource {
  Future<List<TokenEntity>> fetchTokens({required TokenEntity tokenEntity});
}
