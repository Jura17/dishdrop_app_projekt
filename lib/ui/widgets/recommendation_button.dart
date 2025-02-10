import 'dart:math';

import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/recipe_controller.dart';

import 'package:dishdrop_app_projekt/data/shopping_list_controller.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recommendation_card_view_widgets/recommendation_card.dart';
import 'package:flutter/material.dart';

class RecommendationButton extends StatelessWidget {
  const RecommendationButton({
    super.key,
    required this.allRecipes,
    required this.recipeController,
    required this.shoppingListController,
  });

  final List<Recipe> allRecipes;
  final RecipeController recipeController;
  final ShoppingListController shoppingListController;

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      padding: EdgeInsets.all(25),
      onPressed: () {
        getRandomRecipe(context);
      },
      icon: Icon(
        Icons.lightbulb_outline_rounded,
        size: 125,
      ),
      style:
          IconButton.styleFrom(backgroundColor: Theme.of(context).primaryColor),
    );
  }

  void getRandomRecipe(context) {
    int randomIndex = Random().nextInt(allRecipes.length);
    Recipe randomRecipe = allRecipes[randomIndex];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return RecommendationCard(
            recipe: randomRecipe,
            recipeController: recipeController,
            shoppingListController: shoppingListController,
            getRandomRecipeFunc: getRandomRecipe);
      },
    );
  }
}
