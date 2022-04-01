import 'package:flutter/cupertino.dart';
import 'package:whallet/src/portifolio/models/token_model.dart';

abstract class TokenState {}

class InitialTokenState extends TokenState {}

class LoadingTokenState extends TokenState {}

class ErrorTokenState extends TokenState {
  final String message;
  ErrorTokenState({required this.message});
}

class SuccessTokenState extends TokenState {
  final List<TokenModel> tokens;

  SuccessTokenState({this.tokens = const []});
}
