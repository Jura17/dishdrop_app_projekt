import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/repositories/mock_database.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_card.dart';
import 'package:flutter/material.dart';

class RecipesGridView extends StatelessWidget {
  const RecipesGridView({super.key, required this.category, required this.db});
  final String category;
  final MockDatabase db;

  @override
  Widget build(BuildContext context) {
    List<Recipe> allRecipes = db.getAllRecipes();
    List<Recipe> filteredRecipes =
        allRecipes.where((recipe) => recipe.category == category).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(category, style: Theme.of(context).textTheme.headlineLarge),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 0.6,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            for (final recipe in filteredRecipes) RecipeCard(recipe: recipe)
          ],
        ),
      ),
    );
  }
}
