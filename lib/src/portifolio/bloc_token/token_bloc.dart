import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whallet/src/portifolio/bloc_token/token_event.dart';
import 'package:whallet/src/portifolio/bloc_token/token_state.dart';
import 'package:whallet/src/portifolio/models/token_model.dart';
import 'package:whallet/src/portifolio/services/token_service.dart';

class TokenBloc extends Bloc<TokenEvent, TokenState> {
  final TokenService tokenService;

  final GlobalKey<FormState> formKey;
  final TextEditingController tokenController;
  final FocusNode tokenFocus;
  TokenModel selectedToken;

  TokenBloc({
    required this.tokenService,
    required this.formKey,
    required this.tokenController,
    required this.tokenFocus,
    required this.selectedToken,
  }) : super(InitialTokenState()) {
    on<FetchTokensEvent>(_fetchTokensEvent);
    on<CreateTokenEvent>(_createTokenEvent);
    on<SelectTokenEvent>(_selectTokenEvent);
  }

  Future<void> _fetchTokensEvent(FetchTokensEvent event, emit) async {
    emit(LoadingTokenState());
    try {
      final tokens = await tokenService.getTokensByInfo(tokenModel: event.tokenModel);
      emit(SuccessTokenState(tokens: tokens));
    } catch (e) {
      emit(ErrorTokenState(message: 'Não foi possível carregar os tokens.'));
    }
  }

  Future<void> _createTokenEvent(CreateTokenEvent event, emit) async {
    emit(LoadingTokenState());
    if ((event.tokenModel.symbol ?? '') == '') {
      emit(ErrorTokenState(message: 'Não foi possível adicioanr o token'));
    } else {
      emit(SuccessTokenState());
    }
  }

  void _selectTokenEvent(SelectTokenEvent event, emit) {
    emit(SuccessTokenState(tokens: event.tokens));
  }
}
