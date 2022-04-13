import 'package:whallet/src/portifolio/models/token_model.dart';

abstract class TokenState {}

class InitialTokenState extends TokenState {}

class LoadingTokenState extends TokenState {}

class ErrorTokenState extends TokenState {
  final String message;
  ErrorTokenState({required this.message});
}

class SuccessSelectTokenState extends TokenState {
  final List<TokenModel> tokens;
  TokenModel selectedToken;

  SuccessSelectTokenState({this.tokens = const [], required this.selectedToken});
}

class SuccessTokenState extends TokenState {
  final List<TokenModel> tokens;

  SuccessTokenState({this.tokens = const []});
}

class SuccessTokenSaveState extends TokenState {}

class SuccessTokenRemoveState extends TokenState {}

class SuccessTokenFetchState extends TokenState {
  TokenModel tokenModel;

  SuccessTokenFetchState({required this.tokenModel});
}
