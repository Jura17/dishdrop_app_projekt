import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/recipe_controller.dart';
import 'package:dishdrop_app_projekt/data/shopping_list_controller.dart';
import 'package:dishdrop_app_projekt/ui/screens/new_recipe_screen.dart';

import 'package:dishdrop_app_projekt/ui/widgets/custom_filled_icon_button.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_card_widgets/recipe_card.dart';
import 'package:flutter/material.dart';

class RecipesGridView extends StatelessWidget {
  const RecipesGridView({
    super.key,
    required this.category,
    required this.recipeController,
    required this.shoppingListController,
  });
  final String category;
  final RecipeController recipeController;
  final ShoppingListController shoppingListController;

  @override
  Widget build(BuildContext context) {
    List<Recipe> allRecipes = recipeController.getAllRecipes();
    List<Recipe> filteredRecipes =
        allRecipes.where((recipe) => recipe.category == category).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(category, style: Theme.of(context).textTheme.headlineLarge),
      ),
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 16, bottom: 64, left: 8, right: 8),
          child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 0.6,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                ...filteredRecipes.map((recipe) => RecipeCard(
                      recipe: recipe,
                      recipeController: recipeController,
                      shoppingListController: shoppingListController,
                    ))
              ]
              // alternative 1: [for (final recipe in filteredRecipes) RecipeCard(recipe: recipe)]
              // alternative 2: filteredRecipes.map((recipe) => RecipeCard(recipe: recipe)).toList(),
              ),
        ),
      ),
      floatingActionButton: CustomFilledIconButton(
        text: "Add Recipe",
        iconData: Icons.add_box_outlined,
        recipeController: recipeController,
        shoppingListController: shoppingListController,
        newScreen: NewRecipeScreen(
            recipeController: recipeController,
            shoppingListController: shoppingListController),
      ),
    );
  }
}
