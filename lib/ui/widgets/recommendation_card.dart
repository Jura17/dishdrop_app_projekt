import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/repositories/mock_database.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_card.dart';
import 'package:flutter/material.dart';

class RecommendationCard extends StatelessWidget {
  const RecommendationCard({super.key, required this.recipe, required this.db});

  final Recipe recipe;
  final MockDatabase db;

  @override
  Widget build(BuildContext context) {
    return RecipeCard(recipe: recipe, db: db);
  }
}
