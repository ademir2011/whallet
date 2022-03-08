import 'package:flutter_test/flutter_test.dart';
import 'package:whallet/src/portifolio/models/token_model.dart';
import 'package:whallet/src/portifolio/services/token_service.dart';

void main() {
  late TokenService tokenService;

  setUp(() {
    tokenService = TokenService();
  });

  test('Deve retornar um tokenModel para o Símbolo CAKE', () {
    final tokenModel = TokenModel(symbol: 'CAKE', address: '');
    final token = tokenService.getTokenByInfo(tokenModel: tokenModel);
    expect(token, isNotNull);
  });
  test('Deve retornar null para o Símbolo asdf', () {
    final tokenModel = TokenModel(symbol: 'asdf', address: '');
    final token = tokenService.getTokenByInfo(tokenModel: tokenModel);
    expect(token, isNull);
  });

  test('Deve retornar um TokenModel para o endereço 0x0e09fabb73bd3ade0a17ecc321fd13a19e81ce82', () async {
    final sampleAddress = await tokenService.getTokenByInfo(
      tokenModel: TokenModel.address(address: '0x0e09fabb73bd3ade0a17ecc321fd13a19e81ce82'),
    );
    expect(sampleAddress, isNotNull);
  });
}
