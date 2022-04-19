import 'package:whallet/src/portifolio/domain/entities/token_entity.dart';
import 'package:whallet/src/portifolio/domain/repositories/fetch_tokens_by_symbol_repository_interface.dart';

abstract class IFetchTokensBySymbol {
  Future<List<TokenEntity>> fetchTokensBySymbol({required String symbol});
}

class FetchTokensBySymbol implements IFetchTokensBySymbol {
  final IFetchTokensBySymbolRepository iFetchTokensBySymbolRepository;

  FetchTokensBySymbol({required this.iFetchTokensBySymbolRepository});

  @override
  Future<List<TokenEntity>> fetchTokensBySymbol({required String symbol}) async {
    return await iFetchTokensBySymbolRepository.fetchTokensBySymbol(symbol: symbol);
  }
}
