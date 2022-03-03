import 'package:dio/dio.dart';
import 'package:whallet/src/models/token.dart';

class CoingeckoDatasource {
  Future<Token> getTokenByInfo(Token token) async {
    final dio = Dio();
    final response = await dio.get('https://api.coingecko.com/api/v3/coins/list?include_platform=false');
    final tokens = response.data as List;
    final tokenTemp = tokens.where((element) => element['symbol'] == token.symbol).first;
    final response2 =
        await dio.get('https://api.coingecko.com/api/v3/simple/price?ids=${tokenTemp['id']}&vs_currencies=usd');
    return Token(
      name: tokenTemp['name'],
      address: '',
      symbol: tokenTemp['symbol'],
      usdPrice: double.parse(response2.data[tokenTemp['id']]['usd'].toString()),
    );
  }
}
