import 'package:flutter/material.dart';
import 'package:modora/core/core.dart';

abstract class ModoraTextStyles {
  static const TextStyle bottomBarActive = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: ModoraColors.mainDarker,
    letterSpacing: -0.3,
  );

  static const TextStyle bottomBarInactive = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: ModoraColors.button,
    letterSpacing: -0.3,
  );

  static const TextStyle bottomBarInactiveWhite = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.white,
    letterSpacing: -0.3,
  );
}
