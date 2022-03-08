import 'package:flutter/material.dart';
import 'package:whallet/src/init/stores/splashscreen_store.dart';

class SplashscreenPage extends StatefulWidget {
  const SplashscreenPage({Key? key}) : super(key: key);

  @override
  State<SplashscreenPage> createState() => _SplashscreenPageState();
}

class _SplashscreenPageState extends State<SplashscreenPage> {
  final splashscreenStore = SplashscreenStore();

  @override
  Widget build(BuildContext context) {
    splashscreenStore.initSplash(context: context, seconds: 2);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Text(
          'Whallet',
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
    );
  }
}
