import 'package:whallet/src/portifolio/domain/entities/token_entity.dart';
import 'package:whallet/src/portifolio/infra/datasources/fetch_token_detail_datasource_interface.dart';

class FetchTokenDetailRepository implements IFetchTokenDetailDatasource {
  final IFetchTokenDetailDatasource iFetchTokenDetailDatasource;

  FetchTokenDetailRepository({required this.iFetchTokenDetailDatasource});

  @override
  Future<TokenEntity> fetchTokenDetail({required TokenEntity tokenEntity}) async {
    if (tokenEntity.symbol != null) {
      TokenEntity tokenModelResult = await iFetchTokenDetailDatasource.fetchTokenDetail(tokenEntity: tokenEntity);
      tokenModelResult.updatedAtTokenValue = DateTime.now();
      return tokenModelResult;
    }

    return Future.error(Exception);
  }
}
