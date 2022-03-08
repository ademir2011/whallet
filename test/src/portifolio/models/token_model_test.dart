import 'package:flutter_test/flutter_test.dart';
import 'package:whallet/src/portifolio/models/token_model.dart';

void main() {
  test('Não deve aceitar valores diferente do padrão 0x...', () {
    final address = 'asdasdasdasd2132d12d12d1212d12';
    expect(() => TokenModel(symbol: '', address: address), throwsAssertionError);
  });

  test('Deve aceitar valores no padrão 0x...', () {
    final address = '0xb5fAE81A1c099B5763a69047e89cbEF641E9F4A3';
    expect(() => TokenModel(symbol: '', address: address), isNot(throwsAssertionError));
  });
}
