import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whallet/src/auth/models/user_model.dart';
import 'package:whallet/src/portifolio/bloc_portfolio/portfolio_event.dart';
import 'package:whallet/src/portifolio/bloc_portfolio/portfolio_state.dart';
import 'package:whallet/src/portifolio/services/portfolio_service.dart';

class PortfolioBloc extends Bloc<PortfolioEvent, PortfolioState> {
  final PortfolioService portfolioService;
  PortfolioBloc(this.portfolioService) : super(InitialPortfolioState()) {
    on<FetchTokensPortfolioEvent>(_fetchTokensPortfolioEvent);
  }

  Future<void> _fetchTokensPortfolioEvent(event, emit) async {
    emit(LoadingPortfolioState());
    final tokens = await portfolioService.getTokensByUser(
        userModel: UserModel(login: 'login', password: 'password', email: 'email', uid: 'uid', docRef: 'docRef'));

    emit(SuccessPortfolioState(tokens: tokens));
  }
}
