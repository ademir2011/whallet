import 'package:whallet/src/portifolio/domain/entities/token_entity.dart';

abstract class IFetchTokenDetailDatasource {
  Future<TokenEntity> fetchTokenDetail({required TokenEntity tokenEntity});
}
