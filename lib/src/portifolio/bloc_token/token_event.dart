import 'package:whallet/src/portifolio/domain/entities/token_entity.dart';

abstract class TokenEvent {}

class FetchTokensEvent extends TokenEvent {
  final TokenEntity tokenEntity;
  FetchTokensEvent({required this.tokenEntity});
}

class CreateTokenEvent extends TokenEvent {
  final TokenEntity tokenEntity;
  CreateTokenEvent({required this.tokenEntity});
}

class SelectTokenEvent extends TokenEvent {
  final List<TokenEntity> tokens;
  TokenEntity selectedToken;

  SelectTokenEvent({required this.tokens, required this.selectedToken});
}

class UpdateTokenEvent extends TokenEvent {}

class FetchDetailTokenEvent extends TokenEvent {
  final TokenEntity tokenEntity;
  FetchDetailTokenEvent({required this.tokenEntity});
}

class RemoveTokenEvent extends TokenEvent {
  final TokenEntity tokenEntity;
  RemoveTokenEvent({required this.tokenEntity});
}
