import 'package:dishdrop_app_projekt/data/recipe_controller.dart';
import 'package:dishdrop_app_projekt/data/shopping_list_controller.dart';

import 'package:dishdrop_app_projekt/ui/widgets/recommendation_button.dart';
import 'package:flutter/material.dart';

class RecommendationScreen extends StatefulWidget {
  const RecommendationScreen({
    super.key,
    required this.recipeController,
    required this.shoppingListController,
  });

  final RecipeController recipeController;
  final ShoppingListController shoppingListController;

  @override
  State<RecommendationScreen> createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(
            "Tap the button to find a recipe for today!",
            style: Theme.of(context).textTheme.headlineLarge,
            textAlign: TextAlign.center,
          ),
          Spacer(),
          RecommendationButton(
            shoppingListController: widget.shoppingListController,
            recipeController: widget.recipeController,
            allRecipes: widget.recipeController.getAllRecipes(),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
