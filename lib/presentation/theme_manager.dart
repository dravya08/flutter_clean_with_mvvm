import 'package:flutter/material.dart';

import 'color_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData().copyWith(
    colorScheme: ColorScheme(
      primary: ColorManager.primary,
      onPrimary: ColorManager.primaryOpacity70,
      background: ColorManager.white,
      onBackground: ColorManager.black,
      secondary: ColorManager.grey,
      onSecondary: ColorManager.white,
      error: ColorManager.error,
      onError: ColorManager.white,
      surface: ColorManager.white,
      onSurface: ColorManager.black,
      brightness: Brightness.light,
    ),
  );
}
