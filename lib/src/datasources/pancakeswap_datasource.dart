import 'package:dio/dio.dart';
import 'package:whallet/src/models/token.dart';

class PancakeswapDatasource {
  Future<Token> getTokenByInfo(Token token) async {
    final dio = Dio();
    final response = await dio.get('https://api.pancakeswap.info/api/v2/tokens/${token.address}');

    return token.copyWith(
      name: response.data['data']['name'],
      symbol: response.data['data']['symbol'],
      usdPrice: double.parse(
        response.data['data']['price'],
      ),
    );
  }
}
