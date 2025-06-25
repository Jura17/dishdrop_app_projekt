import 'package:dishdrop_app_projekt/core/router.dart';
import 'package:dishdrop_app_projekt/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: AppTheme.appTheme,
      title: 'DishDrop',
    );
  }
}
