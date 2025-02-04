import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:dishdrop_app_projekt/core/theme/text_theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get appTheme => ThemeData(
        primaryColor: AppColors.primary,
        appBarTheme: AppBarTheme(backgroundColor: AppColors.backdrop),
        scaffoldBackgroundColor: AppColors.backdrop,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColors.backdrop,
          selectedItemColor: AppColors.primary,
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
        textTheme: AppTextTheme.lightTextTheme,
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(backgroundColor: AppColors.primary),
        ),
        inputDecorationTheme: InputDecorationTheme(
            hintStyle: TextStyle(color: AppColors.cardInfoGrey),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: const Color.fromARGB(255, 56, 151, 24)),
            ),
            filled: true,
            fillColor: AppColors.lightGrey),
        dropdownMenuTheme: DropdownMenuThemeData(
          inputDecorationTheme: InputDecorationTheme(
              // TODO: fillColor is supposed to be light grey but it's not changing the current color
              // filled: true,
              // fillColor: AppColors.lightGrey,
              ),
          menuStyle: MenuStyle(
            backgroundColor: WidgetStateColor.resolveWith(
              (states) => AppColors.lightGreen,
            ),
          ),
        ),
        segmentedButtonTheme: SegmentedButtonThemeData(
          style: SegmentedButton.styleFrom(
            side: BorderSide(color: AppColors.primary),
          ),
        ),
      );
}
