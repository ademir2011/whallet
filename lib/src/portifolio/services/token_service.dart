import 'package:whallet/src/portifolio/models/token_model.dart';
import 'package:whallet/src/portifolio/repository/token_repository.dart';

class TokenService {
  final tokenRepository = TokenRepository();

  Future<TokenModel?> getTokenByInfo({required TokenModel tokenModel}) async {
    return tokenRepository.getTokenByInfo(tokenModel);
  }
}
