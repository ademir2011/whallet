import 'package:dio/dio.dart';
import 'package:whallet/src/portifolio/models/token_model.dart';

class CoingeckoDatasource {
  final dio = Dio();

  Future<List<TokenModel>> getTokensBySymbol({required TokenModel tokenModel}) async {
    final responseTokens = await dio.get('https://api.coingecko.com/api/v3/coins/list?include_platform=false');

    if (responseTokens.data == null) NullThrownError();

    final tokens = responseTokens.data as List;
    final tokensFilter = tokens.where((element) => element['symbol'] == tokenModel.symbol).toList();
    return tokensFilter.map((token) => TokenModel(symbol: token['symbol'], name: token['name'])).toList();
  }

  TokenModel? getTokenByList({required List<TokenModel> tokens, required String tokenId}) {
    List<TokenModel> tokensFilter = tokens.where((token) => token.tokenId == tokenId).toList();
    return tokensFilter.isNotEmpty ? tokensFilter.first : null;
  }

  Future<TokenModel?> getTokenBySymbol({required TokenModel tokenModel}) async {
    final tokens = await getTokensBySymbol(tokenModel: tokenModel);
    return getTokenByList(tokens: tokens, tokenId: tokenModel.symbol!);
  }
}
