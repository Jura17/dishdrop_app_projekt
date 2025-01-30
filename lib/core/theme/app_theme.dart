import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:dishdrop_app_projekt/core/theme/text_theme.dart';
import 'package:flutter/material.dart';

class DishDropTheme {
  static ThemeData get lightTheme => ThemeData(
        primaryColor: AppColors.primary,
        appBarTheme: AppBarTheme(backgroundColor: AppColors.backdrop),
        scaffoldBackgroundColor: AppColors.backdrop,
        textTheme: DishDropTextTheme.lightTextTheme,
      );
}
