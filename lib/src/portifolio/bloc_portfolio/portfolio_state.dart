import 'package:whallet/src/portifolio/models/token_model.dart';

abstract class PortfolioState {}

class InitialPortfolioState extends PortfolioState {}

class LoadingPortfolioState extends PortfolioState {}

class ErrorPortfolioState extends PortfolioState {}

class SuccessPortfolioState extends PortfolioState {
  final List<TokenModel> tokens;

  SuccessPortfolioState({required this.tokens});
}
