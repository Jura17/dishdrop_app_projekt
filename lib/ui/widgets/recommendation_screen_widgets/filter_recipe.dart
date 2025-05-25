import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/provider/recipe_notifier.dart';
import 'package:dishdrop_app_projekt/data/repositories/recommendation_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

List<Recipe> filterRecipes(List<Recipe> allRecipes, List<Enum?> answers, BuildContext context) {
  // create shallow copy to prevent modifying source data
  List<Recipe> filtered = List.from(allRecipes);

  // Familiarity threshold setup
  int familiarityThreshold = 0;
  // check if we have already answered the 4th question
  if (answers[3] != null) {
    final timesCooked = allRecipes.map((r) => r.timesCooked).toList()..sort();
    if (timesCooked.isNotEmpty) {
      final thresholdIndex = (timesCooked.length * 0.7).floor();
      familiarityThreshold = timesCooked[thresholdIndex];
    }
  }

  for (int i = 0; i < answers.length; i++) {
    final answer = answers[i];
    // check if question has been answered yet, if not don't apply filter and just continue
    if (answer == null) continue;

    filtered = switch (i) {
      0 => _filterByCategory(filtered, answer),
      1 => _filterByDifficulty(filtered, answer),
      2 => _filterByTime(filtered, answer),
      3 => _filterByFamiliarity(filtered, answer, familiarityThreshold),
      4 => _filterByFavorite(filtered, answer),
      _ => filtered,
    };
  }

  context.read<RecipeNotifier>().updateFilteredRecipe(filtered);
  return filtered;
}

List<Recipe> _filterByCategory(List<Recipe> recipes, Enum answer) {
  final category = switch (answer) {
    CategoriesPreference.appetizers => "Appetizers",
    CategoriesPreference.mainCourses => "Main Courses",
    CategoriesPreference.sideDishes => "Side Dishes",
    CategoriesPreference.salads => "Salads",
    CategoriesPreference.sweetStuff => "Sweet Stuff",
    CategoriesPreference.drinks => "Drinks",
    _ => null,
  };

  return category != null ? recipes.where((recipe) => recipe.category == category).toList() : recipes;
}

List<Recipe> _filterByDifficulty(List<Recipe> recipes, Enum answer) {
  final difficulty = switch (answer) {
    DifficultyPreference.simple => "Simple",
    DifficultyPreference.notTooTricky => "Not Too Tricky",
    DifficultyPreference.impressive => "Impressive",
    _ => null,
  };

  return difficulty != null ? recipes.where((recipe) => recipe.difficulty == difficulty).toList() : recipes;
}

List<Recipe> _filterByTime(List<Recipe> recipes, Enum answer) {
  return switch (answer) {
    TimePreference.veryLittle => recipes.where((recipe) => recipe.prepTime + recipe.cookingTime <= 15).toList(),
    TimePreference.little => recipes.where((recipe) => recipe.prepTime + recipe.cookingTime <= 30).toList(),
    TimePreference.medium => recipes.where((recipe) => recipe.prepTime + recipe.cookingTime <= 60).toList(),
    TimePreference.irrelevant => recipes,
    _ => recipes,
  };
}

List<Recipe> _filterByFamiliarity(List<Recipe> recipes, Enum answer, int threshold) {
  return switch (answer) {
    FamiliarityPreference.unfamiliar => recipes.where((recipe) => recipe.timesCooked == 0).toList(),
    FamiliarityPreference.familiar =>
      recipes.where((recipe) => recipe.timesCooked > 0 && recipe.timesCooked < threshold).toList(),
    FamiliarityPreference.veryFamiliar => recipes.where((recipe) => recipe.timesCooked >= threshold).toList(),
    FamiliarityPreference.irrelevant => recipes,
    _ => recipes,
  };
}

List<Recipe> _filterByFavorite(List<Recipe> recipes, Enum answer) {
  return switch (answer) {
    FavoriteRecipePreference.onlyFavorites => recipes.where((recipe) => recipe.isFavorite).toList(),
    FavoriteRecipePreference.excludeFavorites => recipes.where((recipe) => !recipe.isFavorite).toList(),
    FavoriteRecipePreference.irrelevant => recipes,
    _ => recipes,
  };
}
