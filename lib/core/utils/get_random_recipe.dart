import 'dart:math';

import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recommendation_screen_widgets/recommendation_card.dart';
import 'package:flutter/material.dart';

void getRandomRecipe(context, allRecipes) {
  int randomIndex = Random().nextInt(allRecipes.length);
  Recipe randomRecipe = allRecipes[randomIndex];
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return RecommendationCard(
        recipe: randomRecipe,
      );
    },
  );
}
