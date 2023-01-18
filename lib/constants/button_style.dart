import 'package:flutter/material.dart';

import './dimens.dart';

class AppButtonStyle {
  AppButtonStyle._();

  static final ButtonStyle generalButtonStyle = TextButton.styleFrom(
    elevation: 0,
    padding: Dimens.buttonSpacing,
    shape: const StadiumBorder(),
  );
}
