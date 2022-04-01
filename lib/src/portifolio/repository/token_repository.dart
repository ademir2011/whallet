import 'package:whallet/src/auth/models/user_model.dart';
import 'package:whallet/src/portifolio/datasources/coingecko_datasource.dart';
import 'package:whallet/src/portifolio/datasources/pancakeswap_datasource.dart';
import 'package:whallet/src/portifolio/models/token_model.dart';

class TokenRepository {
  final CoingeckoDatasource coingeckoDatasource;
  final PancakeswapDatasource pancakeswapDatasource;

  TokenRepository(this.coingeckoDatasource, this.pancakeswapDatasource);

  Future<TokenModel?> getTokenByInfo({required TokenModel tokenModel}) async {
    if (tokenModel.symbol != null) {
      return await coingeckoDatasource.getTokenBySymbol(tokenModel: tokenModel);
    } else if (tokenModel.address != null) {
      return await pancakeswapDatasource.getTokenByAddress(tokenModel: tokenModel);
    }
    return Future.error(Exception);
  }

  Future<List<TokenModel>> getTokensByInfo({required TokenModel tokenModel}) async {
    if (tokenModel.symbol != null) {
      return await coingeckoDatasource.getTokensBySymbol(tokenModel: tokenModel);
    }
    return Future.error(Exception);
  }
}
