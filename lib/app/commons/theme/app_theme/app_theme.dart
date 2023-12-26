import 'package:flutter/material.dart';
import 'package:store/app/commons/theme/app_theme/buttons_theme.dart';
import 'package:store/app/commons/theme/app_theme/color_scheme_theme.dart';
import 'package:store/app/commons/theme/app_theme/text_theme.dart';

class AppTheme {
  static ThemeData theme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: lightColorScheme,
      scaffoldBackgroundColor: lightColorScheme.background,
      elevatedButtonTheme: ElevatedButtonThemeApp.theme(lightColorScheme),
      textButtonTheme: TextButtonThemeApp.theme(lightColorScheme),
      textTheme: TextThemeApp.theme,
    );
  }
}
