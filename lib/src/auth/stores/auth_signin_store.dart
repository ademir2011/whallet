import 'package:flutter/cupertino.dart';

class AuthSigninStore {
  late final FocusNode _emailFocus;
  late final FocusNode _passwordFocus;

  FocusNode get emailFocus => _emailFocus;
  FocusNode get passwordFocus => _passwordFocus;

  void initFocusNodes() {
    _emailFocus = FocusNode();
    _passwordFocus = FocusNode();
  }

  void addFocusLiteners(void Function() callback) {
    _emailFocus.addListener(callback);
    _passwordFocus.addListener(callback);
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? emailValidator(value) {}

  String? passwordValidator(value) {}

  void focusNodesDispose() {
    _emailFocus.dispose();
    _passwordFocus.dispose();
  }
}
