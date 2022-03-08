import 'package:flutter/cupertino.dart';

class AuthSignUpStore {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();
  final confirmPasswordFocus = FocusNode();

  String? emailValidator(String? value) => null;
  String? passwordValidator(String? value) => null;
  String? confirmPasswordValidator(String? value) => null;

  void addFocusListeners(void Function() callback) {
    emailFocus.addListener(callback);
    passwordFocus.addListener(callback);
    confirmPasswordFocus.addListener(callback);
  }

  void disposeAllFocus() {
    emailFocus.dispose();
    passwordFocus.dispose();
    confirmPasswordFocus.dispose();
  }
}
