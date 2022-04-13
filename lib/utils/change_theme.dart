import 'package:flutter/cupertino.dart';

class ChangeTheme extends ChangeNotifier {
  var switchTheme = false;

  void toogleSwitch(bool value) {
    switchTheme = value;
    notifyListeners();
  }
}
