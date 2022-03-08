import 'package:flutter_test/flutter_test.dart';
import 'package:whallet/src/portifolio/models/token_model.dart';
import 'package:whallet/src/portifolio/services/token_service.dart';

void main() {
  late TokenService tokenService;

  setUp(() {
    tokenService = TokenService();
  });

  test('Deve retornar um tokenModel para o Símbolo CAKE', () {
    final tokenModel = TokenModel(symbol: 'CAKE');
    final token = tokenService.getTokenByInfo(tokenModel: tokenModel);
    expect(token, isNotNull);
  });
  test('Deve retornar null para o Símbolo asdf', () async {
    final tokenModel = TokenModel(symbol: 'asdf');
    final token = await tokenService.getTokenByInfo(tokenModel: tokenModel);
    expect(token, isNull);
  });

  test('Deve retornar um TokenModel para o endereço 0x0e09fabb73bd3ade0a17ecc321fd13a19e81ce82', () async {
    final tokenModel = TokenModel.address(address: '0x0e09fabb73bd3ade0a17ecc321fd13a19e81ce82');
    final sampleAddress = await tokenService.getTokenByInfo(tokenModel: tokenModel);
    expect(sampleAddress, isNotNull);
  });

  test('Deve retornar null para o endereço 0x0esdasd22', () async {
    final tokenModel = TokenModel.address(address: '0x0esdasd22');
    final sampleAddress = await tokenService.getTokenByInfo(tokenModel: tokenModel);
    expect(sampleAddress, isNull);
  });
}
