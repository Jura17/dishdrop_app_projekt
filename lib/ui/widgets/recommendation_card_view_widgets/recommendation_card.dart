import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/recipe_controller.dart';

import 'package:dishdrop_app_projekt/data/shopping_list_controller.dart';

import 'package:dishdrop_app_projekt/ui/widgets/recommendation_card_view_widgets/recommendation_card_image_section.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recommendation_card_view_widgets/recommendation_card_info_section.dart';

import 'package:flutter/material.dart';

class RecommendationCard extends StatelessWidget {
  const RecommendationCard({
    super.key,
    required this.recipe,
    required this.recipeController,
    required this.shoppingListController,
    required this.getRandomRecipeFunc,
  });

  final Recipe recipe;
  final RecipeController recipeController;
  final ShoppingListController shoppingListController;
  final Function getRandomRecipeFunc;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              RecommendationCardImageSection(recipe: recipe),
              RecommendationCardInfoSection(
                  recipe: recipe,
                  getRandomRecipeFunc: getRandomRecipeFunc,
                  recipeController: recipeController,
                  shoppingListController: shoppingListController),
            ],
          ),
        ),
      ),
    );
  }
}
