import 'package:dio/dio.dart';
import 'package:whallet/src/portifolio/domain/entities/token_entity.dart';
import 'package:whallet/src/portifolio/infra/datasources/fetch_token_detail_datasource_interface.dart';
import 'package:whallet/src/portifolio/infra/models/token_model.dart';

class CoingeckoFetchTokenDetail implements IFetchTokenDetailDatasource {
  final Dio dio;

  CoingeckoFetchTokenDetail({required this.dio});

  TokenEntity getTokenByList({required List<TokenEntity> tokens, required String tokenId}) {
    List<TokenEntity> tokensFilter = tokens.where((token) => token.tokenId == tokenId).toList();
    return tokensFilter.isNotEmpty ? tokensFilter.first : TokenModel();
  }

  @override
  Future<TokenEntity> fetchTokenDetail({required TokenEntity tokenEntity}) async {
    final responseTokens = await dio.get('https://api.coingecko.com/api/v3/coins/list?include_platform=false');

    if (responseTokens.data == null) NullThrownError();

    final tokens = responseTokens.data as List;
    final tokensFilter = tokens.where((element) => element['symbol'] == tokenEntity.symbol).toList();
    final tokensResult = tokensFilter
        .map((token) => TokenEntity(
              symbol: token['symbol'],
              name: token['name'],
              tokenId: token['id'],
            ))
        .toList();

    return getTokenByList(tokens: tokensResult, tokenId: tokenEntity.symbol!);
  }
}
