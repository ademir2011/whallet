import 'package:whallet/src/portifolio/domain/entities/token_entity.dart';

abstract class IFetchTokensBySymbolRepository {
  Future<List<TokenEntity>> fetchTokensBySymbol({required String symbol});
}
