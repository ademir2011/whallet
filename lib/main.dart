import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whallet/src/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const AppWidget());
}
