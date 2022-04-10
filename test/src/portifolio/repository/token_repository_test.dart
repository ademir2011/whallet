import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:whallet/src/portifolio/datasources/coingecko_datasource.dart';
import 'package:whallet/src/portifolio/datasources/pancakeswap_datasource.dart';
import 'package:whallet/src/portifolio/models/token_model.dart';
import 'package:whallet/src/portifolio/repository/token_repository.dart';

class DioMock extends Mock implements DioForNative {}

class ResponseMock extends Mock implements Response {}

class FirebaseFirestoreMock extends Mock implements FirebaseFirestore {}

void main() {
  testWidgets('Deve retornar uma lista de horários baseado no token', (tester) async {
    final dioMock = DioMock();
    final responseMock = ResponseMock();

    when(() => responseMock.data).thenReturn(jsonDecode(r'''{
                "prices": [
                  [
                    1649435447047,
                    43684.11476515274
                  ],
                  [
                    1649435648825,
                    43619.34830220211
                  ],
                  [
                    1649435936839,
                    43616.400681250896
                  ],
                  [
                    1649436250647,
                    43625.44012179275
                  ],
                  [
                    1649436557316,
                    43607.92790485945
                  ],
                  [
                    1649436883021,
                    43524.216485564655
                  ],
                  [
                    1649437209649,
                    43509.288364341606
                  ],
                  [
                    1649437405917,
                    43497.747705947586
                  ],
                  [
                    1649437729607,
                    43434.01658403064
                  ],
                  [
                    1649438061021,
                    43338.50110457331
                  ],
                  [
                    1649438381683,
                    43118.355830152446
                  ],
                  [
                    1649438724112,
                    43109.220968941256
                  ]
                ],
                "market_caps": [
                  [
                    1649435447047,
                    830465025394.8102
                  ]
                
                ],
                "total_volumes": [
                  [
                    1649435447047,
                    20824518957.73859
                  ]
                ]
              }'''));

    when(() => dioMock.get(any())).thenAnswer((invocation) async => responseMock);

    final tokenRepository = TokenRepository(
      firebaseFirestore: FirebaseFirestoreMock(),
      coingeckoDatasource: CoingeckoDatasource(),
      pancakeswapDatasource: PancakeswapDatasource(),
      dio: dioMock,
    );

    expect(
      await tokenRepository.getMean24TokenPrice(
        tokenModel: TokenModel.symbol(symbol: 'btc').copyWith(
          updatedAtTokenValue: DateTime.now(),
        ),
      ),
      isA<double>(),
    );
  });
}
