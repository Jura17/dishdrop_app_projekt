import 'package:flutter/material.dart';

class DishDropTextTheme {
  static TextTheme get lightTextTheme => TextTheme(
        headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w800),
        headlineMedium: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        headlineSmall: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
        titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        titleSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        labelLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
      );
}
