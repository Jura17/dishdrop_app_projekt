import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextTheme {
  static TextTheme get lightTextTheme => TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w800,
          color: AppColors.dishDropBlack,
        ),
        headlineMedium: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: AppColors.dishDropBlack,
        ),
        headlineSmall: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: AppColors.dishDropBlack,
        ),
        bodyLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.normal,
          color: AppColors.dishDropBlack,
        ),
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.dishDropBlack,
        ),
        titleSmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: AppColors.dishDropBlack,
        ),
        labelLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.normal,
          color: AppColors.dishDropBlack,
        ),
        displayLarge: TextStyle(color: AppColors.dishDropBlack),
        displayMedium: TextStyle(color: AppColors.dishDropBlack),
        displaySmall: TextStyle(color: AppColors.dishDropBlack),
      );
}
