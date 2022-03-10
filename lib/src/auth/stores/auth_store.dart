import 'package:flutter/material.dart';

abstract class AuthStore extends ChangeNotifier {
  bool isLoading = false;
  bool isErrorFields = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();
  final confirmPasswordFocus = FocusNode();

  String? emailValidator(String? value) {
    final _value = value ?? '';
    if (_value.isEmpty) return 'Campo vazio';
    if (!RegExp(r'[a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+').hasMatch(_value)) return 'Formato incorreto.';
    return null;
  }

  String? passwordValidator(String? value) {
    final _value = value ?? '';
    if (_value.isEmpty) return 'Campo vazio';
    return null;
  }

  String? confirmPasswordValidator(String? value) {
    final _value = value ?? '';
    if (_value.isEmpty) return 'Campo vazio';
    if (passwordController.text != _value) return 'Senha não confere';
    return null;
  }

  void addFocusListeners(void Function() callback) {
    emailFocus.addListener(callback);
    passwordFocus.addListener(callback);
    confirmPasswordFocus.addListener(callback);
  }

  void disposeAll() {
    disposeAllFocus();
    dispose();
  }

  void disposeAllFocus() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    confirmPasswordFocus.dispose();
  }

  void toogleLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
