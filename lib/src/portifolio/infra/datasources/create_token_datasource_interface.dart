import 'package:whallet/src/portifolio/domain/entities/token_entity.dart';

abstract class ICreateTokenDatasource {
  Future<void> createToken({required TokenEntity tokenEntity});
}
