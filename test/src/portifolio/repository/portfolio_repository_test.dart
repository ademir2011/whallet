import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:whallet/src/portifolio/datasources/coingecko_datasource.dart';
import 'package:whallet/src/portifolio/datasources/pancakeswap_datasource.dart';
import 'package:whallet/src/portifolio/models/token_model.dart';
import 'package:whallet/src/portifolio/repository/portfolio_repository.dart';
import 'package:whallet/src/portifolio/repository/token_repository.dart';

class DioMock extends Mock implements DioForNative {}

class ResponseMock extends Mock implements Response {}

class FirebaseFirestoreMock extends Mock implements FirebaseFirestore {}

class TokenRepositoryMock extends Mock implements TokenRepository {}

void main() {
  setUpAll(() {});
  test('Deve receber valores dos tokens', () async {
    final dioMock = DioMock();
    final responseMock = ResponseMock();

    when(() => responseMock.data).thenReturn(jsonDecode(
        r'''{
              "bitcoin": {
                "usd": 43036
              },
              "illuvium": {
                "usd": 600.01
              }
            }'''));

    when(() => dioMock.get(any<String>())).thenAnswer((invocation) async => responseMock);

    final portfolioRepository = PortfolioRepository(
      firebaseFirestore: FirebaseFirestoreMock(),
      dio: dioMock,
      tokenRepository: TokenRepository(
        dio: Dio(),
        coingeckoDatasource: CoingeckoDatasource(),
        firebaseFirestore: FirebaseFirestore.instance,
        pancakeswapDatasource: PancakeswapDatasource(),
      ),
    );

    final tokens = [TokenModel.symbol(symbol: 'bitcoin'), TokenModel.symbol(symbol: 'illuvium')];

    expect(await portfolioRepository.getPriceByToken(tokensModel: tokens), isA<List<TokenModel>>());
  });
}
