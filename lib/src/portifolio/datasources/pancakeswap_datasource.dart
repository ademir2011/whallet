import 'package:dio/dio.dart';
import 'package:whallet/src/portifolio/models/token_model.dart';

class PancakeswapDatasource {
  final dio = Dio();

  Future<TokenModel?> getTokenByAddress({required TokenModel tokenModel}) async {
    late Response response;

    try {
      response = await dio.get('https://api.pancakeswap.info/api/v2/tokens/${tokenModel.address}');
    } catch (e) {
      return null;
    }

    return tokenModel.copyWith(
      name: response.data['data']['name'],
      symbol: response.data['data']['symbol'],
      usdPrice: double.parse(
        response.data['data']['price'],
      ),
    );
  }
}
