import 'package:flutter/material.dart';

class NavigationController {
  static void goTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  static void replaceWith(BuildContext context, Widget page) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  static void goBack(BuildContext context) {
    Navigator.pop(context);
  }
}
