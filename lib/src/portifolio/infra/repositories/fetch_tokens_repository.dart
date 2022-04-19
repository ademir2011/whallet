import 'package:whallet/src/portifolio/domain/entities/token_entity.dart';
import 'package:whallet/src/portifolio/domain/repositories/fetch_tokens_repository_interface.dart';
import 'package:whallet/src/portifolio/infra/datasources/fetch_token_detail_datasource_interface.dart';
import 'package:whallet/src/portifolio/infra/datasources/fetch_tokens_datasource_interface.dart';

class FetchTokensRepository implements IFetchTokensRepository {
  final IFetchTokensDatasource iFetchTokensDatasource;

  FetchTokensRepository({required this.iFetchTokensDatasource});

  @override
  Future<List<TokenEntity>> fetchTokens({required TokenEntity tokenEntity}) async {
    if (tokenEntity.symbol != null) {
      return await iFetchTokensDatasource.fetchTokens(tokenEntity: tokenEntity);
    }
    return Future.error(Exception);
  }
}
