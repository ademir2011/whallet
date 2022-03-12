import 'package:flutter/cupertino.dart';
import 'package:whallet/src/portifolio/models/token_model.dart';

class CriptoStore extends ChangeNotifier {
  final criptoSymbolController = TextEditingController();
  final criptoSymbolFocus = FocusNode();
  var isLoading = false;

  late final List<TokenModel> searchTokens;

  void toogleLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  String? criptoSymbolValidate(String? value) {
    return null;
  }

  void searchCrypto() {
    toogleLoading();
    Future.delayed(const Duration(seconds: 2)).then((value) {
      searchTokens = [
        TokenModel(
          name: 'BTC',
          usdPrice: 0.985,
        ),
        TokenModel(
          name: 'ETH',
          usdPrice: 3.985,
        ),
        TokenModel(
          name: 'SOL',
          usdPrice: 31.985,
        ),
        TokenModel(
          name: 'AXS',
          usdPrice: 0.0985,
        ),
        TokenModel(
          name: 'AVAX',
          usdPrice: 410.985,
        ),
        TokenModel(
          name: 'SOL',
          usdPrice: 31.985,
        ),
        TokenModel(
          name: 'AXS',
          usdPrice: 0.0985,
        ),
        TokenModel(
          name: 'AVAX',
          usdPrice: 410.985,
        ),
      ];
      toogleLoading();
    });
  }

  void disposeAll() {
    criptoSymbolFocus.dispose();
    criptoSymbolController.dispose();
  }
}
