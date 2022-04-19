import 'package:whallet/src/portifolio/domain/entities/token_entity.dart';

abstract class TokenState {}

class InitialTokenState extends TokenState {}

class LoadingTokenState extends TokenState {}

class ErrorTokenState extends TokenState {
  final String message;
  ErrorTokenState({required this.message});
}

class SuccessSelectTokenState extends TokenState {
  final List<TokenEntity> tokens;
  TokenEntity selectedToken;

  SuccessSelectTokenState({this.tokens = const [], required this.selectedToken});
}

class SuccessTokenState extends TokenState {
  final List<TokenEntity> tokens;

  SuccessTokenState({this.tokens = const []});
}

class SuccessTokenSaveState extends TokenState {}

class SuccessTokenRemoveState extends TokenState {}

class SuccessTokenFetchState extends TokenState {
  TokenEntity tokenEntity;

  SuccessTokenFetchState({required this.tokenEntity});
}
