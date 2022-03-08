import 'package:flutter/material.dart';

class AuthRecoveryStore {
  final emailController = TextEditingController();

  final emailFocus = FocusNode();

  String? emailValidator(String? value) => null;

  void addFocusListeners(void Function() callback) {
    emailFocus.addListener(callback);
  }

  void disposeAllFocus() {
    emailFocus.dispose();
  }
}
