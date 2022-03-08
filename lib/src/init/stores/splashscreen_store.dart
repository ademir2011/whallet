import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:whallet/utils/routes.dart';

class SplashscreenStore {
  bool isLoaded = false;

  void initSplash({required BuildContext context, required int seconds}) {
    init();
    Future.delayed(Duration(seconds: seconds), () {
      if (isLoaded) {
        Navigator.pushReplacementNamed(context, AppRoute.AUTH_SIGNIN);
      } else {
        initSplash(context: context, seconds: 2);
      }
    });
  }

  void init() async {
    await Firebase.initializeApp();
    isLoaded = true;
  }
}
