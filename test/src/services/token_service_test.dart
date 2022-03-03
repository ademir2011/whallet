import 'package:flutter_test/flutter_test.dart';
import 'package:whallet/src/models/token.dart';
import 'package:whallet/src/services/token_service.dart';

void main() {
  test('Dados utilizando símbolo', () async {
    final tokenService = TokenService();
    final sampleSymbol = await tokenService.getTokenByAddress(
      Token.symbol(symbol: 'mht'),
    );
    print(sampleSymbol.toString());
  });

  test('Dados utilizando endereço', () async {
    final tokenService = TokenService();
    final sampleAddress = await tokenService.getTokenByAddress(
      Token.address(address: '0x5cb2c3ed882e37da610f9ef5b0fa25514d7bc85b'),
    );
    print(sampleAddress.toString());
  });
}
