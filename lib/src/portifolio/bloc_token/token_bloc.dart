import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whallet/src/portifolio/bloc_token/token_event.dart';
import 'package:whallet/src/portifolio/bloc_token/token_state.dart';
import 'package:whallet/src/portifolio/repository/token_repository.dart';

class TokenBloc extends Bloc<TokenEvent, TokenState> {
  final TokenRepository tokenRepository;

  TokenBloc({
    required this.tokenRepository,
  }) : super(InitialTokenState()) {
    on<FetchTokensEvent>(_fetchTokensEvent);
    on<CreateTokenEvent>(_createTokenEvent);
    on<SelectTokenEvent>(_selectTokenEvent);
  }

  Future<void> _fetchTokensEvent(FetchTokensEvent event, emit) async {
    emit(LoadingTokenState());
    try {
      final tokens = await tokenRepository.getTokensByInfo(tokenModel: event.tokenModel);
      emit(SuccessTokenState(tokens: tokens));
    } catch (e) {
      emit(ErrorTokenState(message: 'Não foi possível carregar os tokens.'));
    }
  }

  Future<void> _createTokenEvent(CreateTokenEvent event, emit) async {
    emit(LoadingTokenState());
    if ((event.tokenModel.symbol ?? '') == '') {
      emit(ErrorTokenState(message: 'Não foi possível adicionar o token'));
    } else {
      try {
        tokenRepository.saveToken(tokenModel: event.tokenModel);
        emit(SuccessTokenSaveState());
      } catch (e) {
        emit(ErrorTokenState(message: e.toString()));
      }
    }
  }

  void _selectTokenEvent(SelectTokenEvent event, emit) {
    emit(SuccessSelectTokenState(tokens: event.tokens, selectedToken: event.selectedToken));
  }
}
