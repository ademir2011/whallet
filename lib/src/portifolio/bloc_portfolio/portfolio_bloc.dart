import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whallet/src/auth/models/user_model.dart';
import 'package:whallet/src/portifolio/bloc_portfolio/portfolio_event.dart';
import 'package:whallet/src/portifolio/bloc_portfolio/portfolio_state.dart';
import 'package:whallet/src/portifolio/repository/portfolio_repository.dart';

class PortfolioBloc extends Bloc<PortfolioEvent, PortfolioState> {
  final PortfolioRepository portfolioRepository;
  PortfolioBloc(this.portfolioRepository) : super(InitialPortfolioState()) {
    on<FetchTokensPortfolioEvent>(_fetchTokensPortfolioEvent);
  }

  Future<void> _fetchTokensPortfolioEvent(event, emit) async {
    emit(LoadingPortfolioState());
    try {
      final tokens = await portfolioRepository.getTokensByUser();
      emit(SuccessPortfolioState(tokens: tokens));
    } catch (e) {
      emit(ErrorPortfolioState());
    }
  }
}
