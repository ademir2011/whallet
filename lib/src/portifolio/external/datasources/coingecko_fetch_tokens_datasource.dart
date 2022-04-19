import 'package:dio/dio.dart';
import 'package:whallet/src/portifolio/domain/entities/token_entity.dart';
import 'package:whallet/src/portifolio/infra/datasources/fetch_tokens_datasource_interface.dart';

class CoingeckoFetchTokensDatasource implements IFetchTokensDatasource {
  final dio = Dio();

  @override
  Future<List<TokenEntity>> fetchTokens({required TokenEntity tokenEntity}) async {
    final responseTokens = await dio.get('https://api.coingecko.com/api/v3/coins/list?include_platform=false');

    if (responseTokens.data == null) NullThrownError();

    final tokens = responseTokens.data as List;
    final tokensFilter = tokens.where((element) => element['symbol'] == tokenEntity.symbol).toList();
    return tokensFilter
        .map((token) => TokenEntity(
              symbol: token['symbol'],
              name: token['name'],
              tokenId: token['id'],
            ))
        .toList();
  }
}
