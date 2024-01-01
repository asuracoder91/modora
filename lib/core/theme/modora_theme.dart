import 'package:flutter/material.dart';

abstract class ModoraTheme {
  static ThemeData light = ThemeData(
    fontFamily: "SUITE",
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
        color: Colors.black,
      ),
      headlineSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.2,
        color: Colors.black,
      ),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
    ),
  );
  static ThemeData dark = ThemeData(
    fontFamily: "SUITE",
    textTheme: const TextTheme(),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
    ),
  );
}
