import 'package:whallet/src/portifolio/domain/entities/token_entity.dart';
import 'package:whallet/src/portifolio/domain/repositories/fetch_tokens_repository_interface.dart';

abstract class IFetchTokens {
  Future<List<TokenEntity>> fetchTokens({required TokenEntity tokenEntity});
}

class FetchTokens implements IFetchTokens {
  final IFetchTokensRepository iFetchTokensRepository;

  FetchTokens({required this.iFetchTokensRepository});

  @override
  Future<List<TokenEntity>> fetchTokens({required TokenEntity tokenEntity}) async {
    return await iFetchTokensRepository.fetchTokens(tokenEntity: tokenEntity);
  }
}
