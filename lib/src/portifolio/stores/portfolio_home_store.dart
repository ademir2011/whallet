import 'package:flutter/material.dart';
import 'package:whallet/src/portifolio/models/token_model.dart';

class PortfolioHomeStore extends ChangeNotifier {
  late final List<TokenModel> tokens;
  var isLoading = false;

  void toogleLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  void getTokensByUser() {
    toogleLoading();
    Future.delayed(const Duration(seconds: 2)).then(
      (value) {
        tokens = [
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
        ];
        toogleLoading();
      },
    );
  }

  void openInsertTokenModal() {}
}
