import 'package:flutter/material.dart';
import 'package:whallet/src/auth/stores/auth_store.dart';
import 'package:whallet/utils/routes.dart';

class AuthSigninStore extends AuthStore {
  final _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get formKey => _formKey;
  Function(BuildContext) get submit => _submit;

  void signIn(BuildContext context) {
    toogleLoading();
    Future.delayed(const Duration(seconds: 2)).then((value) {
      toogleLoading();
      Navigator.pushNamed(context, AppRoute.PORTFOLIO_HOME);
    });
  }

  void _submit(context) {
    if (_formKey.currentState!.validate()) {
      signIn(context);
    }

    notifyListeners();
  }
}
