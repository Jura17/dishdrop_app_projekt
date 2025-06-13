import 'package:dishdrop_app_projekt/core/theme/app_theme.dart';

import 'package:dishdrop_app_projekt/data/provider/recipe_notifier.dart';
import 'package:dishdrop_app_projekt/data/provider/shopping_list_notifier.dart';

import 'package:dishdrop_app_projekt/data/repositories/objectbox.dart';
import 'package:dishdrop_app_projekt/data/repositories/objectbox_database.dart';
import 'package:dishdrop_app_projekt/dish_drop_app.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final objectbox = await ObjectBox.create();
  final db = ObjectboxDatabase(objectbox.store);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RecipeNotifier(db)),
        ChangeNotifierProvider(create: (_) => ShoppingListNotifier(db)),
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.appTheme,
      home: DishDropApp(),
    );
  }
}
