import 'package:flutter/material.dart';

abstract class ModoraTheme {
  static ThemeData light = ThemeData(
    fontFamily: "SUITE",
    textTheme: const TextTheme(),
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
