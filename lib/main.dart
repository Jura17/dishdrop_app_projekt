import 'package:dishdrop_app_projekt/core/theme/app_theme.dart';
import 'package:dishdrop_app_projekt/data/repositories/mock_database.dart';
import 'package:dishdrop_app_projekt/dish_drop_app.dart';

import 'package:flutter/material.dart';

void main() {
  MockDatabase mockDatabase = MockDatabase();

  runApp(MainApp(db: mockDatabase));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.db});

  final MockDatabase db;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: DishDropTheme.lightTheme,
      home: DishDropApp(db: db),
    );
  }
}
