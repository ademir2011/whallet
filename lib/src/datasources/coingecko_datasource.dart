import 'package:dio/dio.dart';
import 'package:whallet/src/models/token.dart';

class CoingeckoDatasource {
  final dio = Dio();
  Future<Token> getTokenByInfo(Token token) async {
    final responseTokens = await dio.get('https://api.coingecko.com/api/v3/coins/list?include_platform=false');
    final tokens = responseTokens.data as List;
    final tokenTemp = tokens.where((element) => element['symbol'] == token.symbol).first;
    final responseTokenInfo =
        await dio.get('https://api.coingecko.com/api/v3/simple/price?ids=${tokenTemp['id']}&vs_currencies=usd');
    return token.copyWith(
      name: tokenTemp['name'],
      address: '',
      symbol: tokenTemp['symbol'],
      usdPrice: double.parse(responseTokenInfo.data[tokenTemp['id']]['usd'].toString()),
    );
  }
}
