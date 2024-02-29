import 'package:flutter/material.dart';

class AppNavigator {
  static void goBack(BuildContext context) {
    Navigator.pop(context);
  }

  static void replaceToNextScreen(BuildContext context, Widget screen) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => screen,
        transitionDuration: const Duration(milliseconds: 300),
        transitionsBuilder: (_, a, __, c) => FadeTransition(
          opacity: a,
          child: c,
        ),
      ),
    );
  }

  static void replaceAllScreens(BuildContext context, Widget screen) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => screen,
      ),
      (route) => false,
    );
  }

  static void goToNextScreen(BuildContext context, Widget screen) async {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => screen,
        transitionDuration: const Duration(milliseconds: 300),
        transitionsBuilder: (_, a, __, c) => FadeTransition(
          opacity: a,
          child: c,
        ),
      ),
    );
  }
}
