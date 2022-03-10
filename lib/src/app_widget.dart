import 'package:flutter/material.dart';
import 'package:whallet/src/auth/pages/auth_recovery_page.dart';
import 'package:whallet/src/auth/pages/auth_signin_page.dart';
import 'package:whallet/src/auth/pages/auth_signup_page.dart';
import 'package:whallet/src/init/pages/splashscreen_page.dart';
import 'package:whallet/utils/routes.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      theme: ThemeData.light().copyWith(),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: const ColorScheme.dark().copyWith(
          primary: const Color(0xff04E76F),
          secondary: const Color(0xff323238),
        ),
        scaffoldBackgroundColor: const Color(0xff202024),
        textTheme: const TextTheme(
          labelLarge: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 50,
            color: Color(0xff04E76F),
            fontWeight: FontWeight.w600,
            shadows: [
              Shadow(color: Color(0xff04E76F), blurRadius: 20),
              Shadow(color: Color(0xff04E76F), blurRadius: 10)
            ],
          ),
          labelMedium: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 30,
            color: Color(0xff04E76F),
            fontWeight: FontWeight.w600,
          ),
          titleLarge: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 25,
            color: Color(0xff04E76F),
            fontWeight: FontWeight.w700,
          ),
          bodyLarge: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 15,
            color: Color(0xff04E76F),
            fontWeight: FontWeight.w700,
          ),
          bodyMedium: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 15,
            color: Color(0xffECECEC),
            fontWeight: FontWeight.w700,
          ),
          bodySmall: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 12.5,
            color: Color(0xffECECEC),
            fontWeight: FontWeight.w700,
          ),
          labelSmall: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 15,
            color: Color(0xff323238),
            fontWeight: FontWeight.w700,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: const Color(0xff04E76F),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
        iconTheme: const IconThemeData(
          size: 30,
          color: Color(0xff04E76F),
        ),
        cardColor: const Color(0xff323238),
        errorColor: const Color(0xffDC3545),
      ),
      home: const SplashscreenPage(),
      routes: {
        AppRoute.SPLASHSCREEN: (ctx) => const SplashscreenPage(),
        AppRoute.AUTH_SIGNIN: (ctx) => const AuthSigninPage(),
        AppRoute.AUTH_SIGNUP: (ctx) => const AuthSighUpPage(),
        AppRoute.AUTH_RECOVERY: (ctx) => const AuthRecoveryPage(),
      },
    );
  }
}
