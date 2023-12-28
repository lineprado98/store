import 'package:flutter/material.dart';
import 'package:store/app/commons/theme/app_theme/text_theme.dart';

class ElevatedButtonThemeApp {
  static ElevatedButtonThemeData theme(ColorScheme colorScheme) {
    return ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: const MaterialStatePropertyAll(1),
        textStyle: MaterialStateProperty.all(TextThemeApp.theme.bodyLarge?.copyWith(
          color: colorScheme.inversePrimary,
          fontWeight: FontWeight.w700,
        )),
        padding: MaterialStateProperty.all(const EdgeInsets.all(16)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        )),
      ),
    );
  }
}
