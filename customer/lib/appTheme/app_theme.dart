
import 'package:flutter/material.dart';
import 'package:kicksy/appTheme/app_color.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColor.primaryColor,
    scaffoldBackgroundColor: Colors.yellow[50],

    // appBarTheme: const AppBarTheme(
    //   backgroundColor: Colors.yellow,
    //   foregroundColor: Colors.white,
    //   elevation: 0,
    // ),
    dialogTheme: const DialogThemeData(
      backgroundColor: AppColor.backgroundLight,
    ),
    drawerTheme: const DrawerThemeData(backgroundColor: AppColor.primaryColor),
    cardTheme: const CardThemeData(color: AppColor.primaryColor),
    iconTheme: const IconThemeData(color: AppColor.primaryColor),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColor.buttonColor,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: AppColor.textPrimary),
      displayMedium: TextStyle(color: AppColor.textPrimary),
      displaySmall: TextStyle(color: AppColor.textSecondary),
      headlineLarge: TextStyle(color: AppColor.textPrimary),
      headlineMedium: TextStyle(color: AppColor.textPrimary),
      headlineSmall: TextStyle(color: AppColor.textSecondary),
      labelLarge: TextStyle(color: AppColor.textPrimary),
      labelMedium: TextStyle(color: AppColor.textPrimary),
      labelSmall: TextStyle(color: AppColor.textSecondary),
      titleLarge: TextStyle(color: AppColor.textPrimary),
      titleMedium: TextStyle(color: AppColor.backgroundLight),
      titleSmall: TextStyle(color: AppColor.textSecondary),
      bodyLarge: TextStyle(color: AppColor.textPrimary),
      bodyMedium: TextStyle(color: AppColor.textSecondary),
      bodySmall: TextStyle(color: AppColor.backgroundLight),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColor.primaryColor,
    scaffoldBackgroundColor: AppColor.backgroundLight,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColor.primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    iconTheme: const IconThemeData(color: AppColor.iconColor),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColor.buttonColor,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColor.textPrimary),
      bodyMedium: TextStyle(color: AppColor.textSecondary),
    ),
  );
}

// | Style Name         | Typical Use                     | Example Font Size |
// | ------------------ | ------------------------------- | ----------------- |
// | **headlineLarge**  | Big titles, main headings       | ~32               |
// | **headlineMedium** | Medium headings, section titles | ~28               |
// | **headlineSmall**  | Small headings                  | ~24               |
// | **titleLarge**     | Page titles or important labels | ~22               |
// | **titleMedium**    | Medium labels, cards titles     | ~16–18            |
// | **titleSmall**     | Small labels, buttons           | ~14               |
// | **bodyLarge**      | Main text content               | ~16               |
// | **bodyMedium**     | Secondary text                  | ~14               |
// | **bodySmall**      | Small text, captions            | ~12               |
// | **labelLarge**     | Buttons, small labels           | ~14               |
// | **labelMedium**    | Tiny buttons or info            | ~12               |
// | **labelSmall**     | Very small captions             | ~10               |
