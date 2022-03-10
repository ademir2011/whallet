import 'package:flutter/cupertino.dart';
import 'package:whallet/src/auth/stores/auth_store.dart';

class AuthSignUpStore extends AuthStore {
  final _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get formKey => _formKey;
  Function() get submit => _submit;

  void signUp() {
    toogleLoading();
    Future.delayed(Duration(seconds: 5)).then((value) {
      toogleLoading();
    });
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      signUp();
    }
    notifyListeners();
  }
}
