import 'package:dio/dio.dart';
import 'package:whallet/src/portifolio/models/token_model.dart';

class PancakeswapDatasource {
  final dio = Dio();

  Future<TokenModel> getTokenByAddress({required TokenModel tokenModel}) async {
    final response = await dio.get('https://api.pancakeswap.info/api/v2/tokens/${tokenModel.address}');

    if (response.data == null) NullThrownError;

    return tokenModel.copyWith(
      name: response.data['data']['name'],
      symbol: response.data['data']['symbol'],
      usdPrice: double.parse(
        response.data['data']['price'],
      ),
    );
  }
}
