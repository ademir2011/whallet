import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:whallet/src/portifolio/bloc_token/token_bloc.dart';
import 'package:whallet/src/portifolio/bloc_token/token_event.dart';
import 'package:whallet/src/portifolio/bloc_token/token_state.dart';
import 'package:whallet/src/portifolio/models/token_model.dart';
import 'package:whallet/src/portifolio/repository/token_repository.dart';

class TokenRepositoryMock extends Mock implements TokenRepository {}

void main() {
  blocTest<TokenBloc, TokenState>(
    'Recebe token',
    build: () {
      registerFallbackValue(TokenModel());

      final tokenRepository = TokenRepositoryMock();

      when(
        () => tokenRepository.getTokensByInfo(
          tokenModel: any<TokenModel>(named: 'tokenModel'),
        ),
      ).thenAnswer(
        (invocation) async => [],
      );

      return TokenBloc(tokenRepository: tokenRepository);
    },
    act: (bloc) => bloc.add(FetchTokensEvent(tokenModel: TokenModel.symbol(symbol: 'sdasd'))),
    expect: () => [
      isA<LoadingTokenState>(),
      isA<SuccessTokenState>(),
    ],
  );
}
