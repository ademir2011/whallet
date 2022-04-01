import 'package:whallet/src/portifolio/models/token_model.dart';

abstract class TokenEvent {}

class FetchTokensEvent extends TokenEvent {
  final TokenModel tokenModel;
  FetchTokensEvent({required this.tokenModel});
}

class CreateTokenEvent extends TokenEvent {
  final TokenModel tokenModel;
  CreateTokenEvent({required this.tokenModel});
}

class SelectTokenEvent extends TokenEvent {
  final List<TokenModel> tokens;

  SelectTokenEvent({required this.tokens});
}

class UpdateTokenEvent extends TokenEvent {}

class RemoveTokenEvent extends TokenEvent {}
