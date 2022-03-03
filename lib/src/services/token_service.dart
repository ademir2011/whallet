import 'dart:collection';

import 'package:whallet/src/models/token.dart';
import 'package:whallet/src/repository/token_repository.dart';

class TokenService {
  final tokenRepository = TokenRepository();

  Future<Token> getTokenByAddress(Token token) async {
    return tokenRepository.getTokenByInfo(token);
  }
}
