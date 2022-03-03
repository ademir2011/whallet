import 'package:whallet/src/datasources/coingecko_datasource.dart';
import 'package:whallet/src/datasources/pancakeswap_datasource.dart';
import 'package:whallet/src/models/token.dart';

class TokenRepository {
  final coingeckoDatasource = CoingeckoDatasource();
  final pancakeswapDatasource = PancakeswapDatasource();

  Future<Token> getTokenByInfo(Token token) async {
    if (token.symbol.isNotEmpty) {
      return coingeckoDatasource.getTokenByInfo(token);
    } else if (token.address.isNotEmpty) {
      return pancakeswapDatasource.getTokenByInfo(token);
    }
    return Future.error(Exception);
  }
}
