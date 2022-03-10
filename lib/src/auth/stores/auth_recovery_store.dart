import 'package:flutter/material.dart';
import 'package:whallet/src/auth/stores/auth_store.dart';

class AuthRecoveryStore extends AuthStore {
  void recovery() {
    toogleLoading();
    Future.delayed(const Duration(seconds: 2)).then((value) => toogleLoading());
  }
}
