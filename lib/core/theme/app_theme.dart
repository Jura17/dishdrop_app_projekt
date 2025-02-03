import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:dishdrop_app_projekt/core/theme/text_theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
      primaryColor: AppColors.primary,
      appBarTheme: AppBarTheme(backgroundColor: AppColors.backdrop),
      scaffoldBackgroundColor: AppColors.backdrop,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        // backgroundColor: const Color.fromARGB(218, 73, 182, 37)),
        backgroundColor: AppColors.backdrop,
        selectedItemColor: AppColors.primary,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
      textTheme: AppTextTheme.lightTextTheme,
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(backgroundColor: AppColors.primary),
      ));
}
