import 'package:whallet/src/auth/models/user_model.dart';
import 'package:whallet/src/portifolio/models/token_model.dart';
import 'package:whallet/src/portifolio/repository/token_repository.dart';

class TokenService {
  final TokenRepository tokenRepository;

  TokenService(this.tokenRepository);

  Future<TokenModel?> getTokenByInfo({required TokenModel tokenModel}) async {
    return await tokenRepository.getTokenByInfo(tokenModel: tokenModel);
  }

  Future<List<TokenModel>> getTokensByInfo({required TokenModel tokenModel}) async {
    return await tokenRepository.getTokensByInfo(tokenModel: tokenModel);
  }
}
