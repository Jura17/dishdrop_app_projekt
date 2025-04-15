import 'package:dishdrop_app_projekt/core/theme/app_theme.dart';
import 'package:dishdrop_app_projekt/data/recipe_controller.dart';
// import 'package:dishdrop_app_projekt/data/repositories/database_repository.dart';
// import 'package:dishdrop_app_projekt/data/repositories/mock_database.dart';
import 'package:dishdrop_app_projekt/data/repositories/objectbox.dart';
import 'package:dishdrop_app_projekt/data/repositories/objectbox_database.dart';
import 'package:dishdrop_app_projekt/data/shopping_list_controller.dart';
import 'package:dishdrop_app_projekt/dish_drop_app.dart';

import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final objectbox = await ObjectBox.create();
  final db = ObjectboxDatabase(objectbox.store);

  // create provider here and use both recipe and shoppingList controller inside provider

  // DatabaseRepository mockDatabase = MockDatabase();
  final RecipeController recipeController = RecipeController(db);
  final ShoppingListController shoppingListController = ShoppingListController(db);

  runApp(
    MainApp(
      recipeController: recipeController,
      shoppingListController: shoppingListController,
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({
    super.key,
    required this.recipeController,
    required this.shoppingListController,
  });

  final RecipeController recipeController;
  final ShoppingListController shoppingListController;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.appTheme,
      home: DishDropApp(
        recipeController: recipeController,
        shoppingListController: shoppingListController,
      ),
    );
  }
}
