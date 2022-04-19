import 'package:whallet/src/portifolio/domain/entities/token_entity.dart';

abstract class IRemoveTokenDatasource {
  Future<void> removeToken({required TokenEntity tokenEntity});
}
