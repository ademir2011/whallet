import 'package:whallet/src/portifolio/datasources/coingecko_datasource.dart';
import 'package:whallet/src/portifolio/datasources/pancakeswap_datasource.dart';
import 'package:whallet/src/portifolio/models/token_model.dart';

class TokenRepository {
  final coingeckoDatasource = CoingeckoDatasource();
  final pancakeswapDatasource = PancakeswapDatasource();

  Future<TokenModel> getTokenByInfo(TokenModel tokenModel) async {
    if (tokenModel.symbol != null) {
      return coingeckoDatasource.getTokenBySymbol(tokenModel: tokenModel);
    } else if (tokenModel.address != null) {
      return pancakeswapDatasource.getTokenByAddress(tokenModel: tokenModel);
    }
    return Future.error(Exception);
  }
}
