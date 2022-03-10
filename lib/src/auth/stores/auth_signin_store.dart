import 'package:flutter/material.dart';
import 'package:whallet/src/auth/stores/auth_store.dart';

class AuthSigninStore extends AuthStore {
  final _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get formKey => _formKey;
  Function() get submit => _submit;

  void signIn() {
    toogleLoading();
    Future.delayed(const Duration(seconds: 2)).then((value) {
      toogleLoading();
    });
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      signIn();
    }
    notifyListeners();
  }
}
