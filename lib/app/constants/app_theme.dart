import 'package:flutter/material.dart';

abstract class AppTheme {
  //* Colors
  static const Color primaryColor = Color(0xff986EFF);
  static const Color backgroundColor = Color(0xffF6F7FB);
  static const Color accentColor = Color(0xff6D5CFF);
  static const Color secondColor = Color(0xffFA7C1B);
  static const Color grayTextColor = Color(0xff707070);
  static const Color yellowColor = Color(0xffF4E135);
  static const Color greenColor = Color(0xff03A930);
  static const Color redColor = Color(0xffDA251D);
  static LinearGradient gradient = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      primaryColor,
      accentColor,
    ],
  );

  static ThemeData themeMobile(BuildContext context) {
    return Theme.of(context).copyWith(
      colorScheme: const ColorScheme(
        primary: primaryColor,
        onPrimary: accentColor,
        secondary: yellowColor,
        onSecondary: accentColor,
        error: redColor,
        onError: redColor,
        background: Colors.transparent,
        onBackground: yellowColor,
        brightness: Brightness.light,
        surface: Colors.white,
        onSurface: accentColor,
      ),
      textTheme: const TextTheme(),
    );
  }
}
