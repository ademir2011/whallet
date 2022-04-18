import 'package:whallet/src/portifolio/domain/entities/token_entity.dart';
import 'package:whallet/src/portifolio/domain/repositories/fetch_detail_token_repository_interface.dart';

abstract class IFetchDetailToken {
  Future<TokenEntity> fetchDetailToken({required TokenEntity tokenEntity});
}

class FetchDetailToken implements IFetchDetailToken {
  final IFetchDetailTokenRepository iFetchDetailTokenRepository;

  FetchDetailToken({required this.iFetchDetailTokenRepository});

  @override
  Future<TokenEntity> fetchDetailToken({required TokenEntity tokenEntity}) async {
    return await iFetchDetailTokenRepository.fetchDetailToken(tokenEntity: tokenEntity);
  }
}
