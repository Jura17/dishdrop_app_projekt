import 'package:dishdrop_app_projekt/core/theme/app_theme.dart';
import 'package:dishdrop_app_projekt/ui/screens/categories.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: const Categories(),
    );
  }
}
