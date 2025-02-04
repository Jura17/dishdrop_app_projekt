import 'dart:math';

import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/repositories/mock_database.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recommendation_card.dart';
import 'package:flutter/material.dart';

class RecommendationButton extends StatelessWidget {
  const RecommendationButton(
      {super.key, required this.allRecipes, required this.db});

  final List<Recipe> allRecipes;
  final MockDatabase db;

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      onPressed: () {
        int randomIndex = Random().nextInt(allRecipes.length);
        Recipe randomRecipe = allRecipes[randomIndex];
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return RecommendationCard(recipe: randomRecipe, db: db);
          },
        );
      },
      icon: Icon(
        Icons.lightbulb_outline_rounded,
        size: 150,
      ),
      style:
          IconButton.styleFrom(backgroundColor: Theme.of(context).primaryColor),
    );
  }
}
