import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  static const MaterialColor red = MaterialColor(
    _redValue,
    <int, Color>{
      50: Color(0xFFfde9ed),
      100: Color(0xFFfbd3db),
      200: Color(0xFFf8a7b7),
      300: Color(0xFFf47a93),
      400: Color(0xFFf14e6f),
      500: Color(_redValue),
      600: Color(0xFFbe1b3c),
      700: Color(0xFF8e142d),
      800: Color(0xFF5f0e1e),
      900: Color(0xFF2f070f),
    },
  );
  static const int _redValue = 0xffec224a;

  static const MaterialColor grayscale = MaterialColor(
    0xff757575,
    <int, Color>{
      50: Color(0xFFF6F6F6),
      100: Color(0xFFEEEEEE),
      200: Color(0xFFE2E2E2),
      300: Color(0xFFCBCBCB),
      400: Color(0xFFAFAFAF),
      500: Color(0xFF757575),
      600: Color(0xFF545454),
      700: Color(0xFF333333),
      800: Color(0xFF242424),
      900: Color(0xFF141414),
    },
  );
}
