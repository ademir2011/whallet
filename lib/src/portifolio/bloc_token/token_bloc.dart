import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whallet/src/portifolio/bloc_token/token_event.dart';
import 'package:whallet/src/portifolio/bloc_token/token_state.dart';
import 'package:whallet/src/portifolio/domain/usecases/create_token.dart';
import 'package:whallet/src/portifolio/domain/usecases/fetch_detail_token.dart';
import 'package:whallet/src/portifolio/domain/usecases/fetch_tokens.dart';
import 'package:whallet/src/portifolio/domain/usecases/remove_token.dart';

class TokenBloc extends Bloc<TokenEvent, TokenState> {
  final CreateToken createToken;
  final FetchDetailToken fetchDetailToken;
  final RemoveToken removeToken;
  final FetchTokens fetchTokens;

  TokenBloc({
    required this.createToken,
    required this.fetchDetailToken,
    required this.fetchTokens,
    required this.removeToken,
  }) : super(InitialTokenState()) {
    on<FetchTokensEvent>(_fetchTokensEvent);
    on<CreateTokenEvent>(_createTokenEvent);
    on<SelectTokenEvent>(_selectTokenEvent);
    on<RemoveTokenEvent>(_removeTokenEvent);
    on<FetchDetailTokenEvent>(_fetchDetailTokenEvent);
  }

  Future<void> _fetchTokensEvent(FetchTokensEvent event, emit) async {
    emit(LoadingTokenState());
    try {
      final tokens = await fetchTokens.fetchTokens(tokenEntity: event.tokenEntity);
      emit(SuccessTokenState(tokens: tokens));
    } catch (e) {
      emit(ErrorTokenState(message: 'Não foi possível carregar os tokens.'));
    }
  }

  Future<void> _createTokenEvent(CreateTokenEvent event, emit) async {
    emit(LoadingTokenState());
    if ((event.tokenEntity.symbol ?? '') == '') {
      emit(ErrorTokenState(message: 'Não foi possível adicionar o token'));
    } else {
      try {
        await createToken.createToken(tokenEntity: event.tokenEntity);
        emit(SuccessTokenSaveState());
      } catch (e) {
        emit(ErrorTokenState(message: e.toString()));
      }
    }
  }

  void _selectTokenEvent(SelectTokenEvent event, emit) {
    emit(SuccessSelectTokenState(tokens: event.tokens, selectedToken: event.selectedToken));
  }

  Future<void> _removeTokenEvent(RemoveTokenEvent event, emit) async {
    emit(LoadingTokenState());
    try {
      await removeToken.removeToken(tokenEntity: event.tokenEntity);
      emit(SuccessTokenRemoveState());
    } catch (e) {
      emit(ErrorTokenState(message: e.toString()));
    }
  }

  Future<void> _fetchDetailTokenEvent(FetchDetailTokenEvent event, emit) async {
    emit(LoadingTokenState());
    try {
      event.tokenEntity.lastHourPrices =
          (await fetchDetailToken.fetchDetailToken(tokenEntity: event.tokenEntity)).lastHourPrices;
      emit(SuccessTokenFetchState(tokenEntity: event.tokenEntity));
    } catch (e) {
      emit(ErrorTokenState(message: 'Error'));
    }
  }
}
