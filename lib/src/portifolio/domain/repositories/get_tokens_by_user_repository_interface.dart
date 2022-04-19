import 'package:whallet/src/portifolio/domain/entities/token_entity.dart';

abstract class IGetTokensByUserRepository {
  Future<List<TokenEntity>> getTokensByUser();
}
