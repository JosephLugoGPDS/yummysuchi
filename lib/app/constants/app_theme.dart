import 'package:flutter/material.dart';

abstract class AppTheme {
  //* Colors
  static const Color primaryColor = Color(0xff5ACAFA);
  static const Color accentColor = Color(0xff0050B3);
  static const Color grayTextColor = Color(0xff707070);
  static const Color yellowColor = Color(0xffF4E135);
  static const Color greenColor = Color(0xff03A930);
  static const Color redColor = Color(0xffDA251D);

  static ThemeData themeMobile(BuildContext context) {
    return Theme.of(context).copyWith(
      colorScheme: const ColorScheme(
        primary: primaryColor,
        onPrimary: accentColor,
        secondary: yellowColor,
        onSecondary: accentColor,
        error: redColor,
        onError: redColor,
        background: Colors.white,
        onBackground: yellowColor,
        brightness: Brightness.light,
        surface: primaryColor,
        onSurface: accentColor,
      ),
      textTheme: const TextTheme(),
    );
  }
}
