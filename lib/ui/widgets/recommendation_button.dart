import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:dishdrop_app_projekt/core/utils/get_random_recipe.dart';
import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/provider/recipe_notifier.dart';
import 'package:dishdrop_app_projekt/data/repositories/recommendation_data.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// TODO: filteredRecipes might be empty because nothing was found on the way and empty list is passed in as function argument
class RecommendationButton extends StatefulWidget {
  const RecommendationButton({
    super.key,
    required this.incrementQuestionIndexFunc,
    required this.currentQuestionIndex,
    required this.answers,
  });

  final Function incrementQuestionIndexFunc;
  final int currentQuestionIndex;
  final Map<int, Enum> answers;

  @override
  State<RecommendationButton> createState() => _RecommendationButtonState();
}

class _RecommendationButtonState extends State<RecommendationButton> {
  late List<Recipe> allRecipes;
  late List<Recipe> filteredRecipes;

  @override
  void initState() {
    allRecipes = context.read<RecipeNotifier>().allRecipes;
    print('init state');
    print(allRecipes.length);
    filteredRecipes = allRecipes;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    filteredRecipes = filterRecipes(filteredRecipes, widget.answers, widget.currentQuestionIndex);
    print('length: ${filteredRecipes.length}');

    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(20),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      label: Icon(
        Icons.lightbulb_outline_rounded,
        size: 125,
      ),
      onPressed: () {
        if (widget.currentQuestionIndex < 0) {
          widget.incrementQuestionIndexFunc();
        } else {
          filteredRecipes = filterRecipes(filteredRecipes, widget.answers, widget.currentQuestionIndex);
          getRandomRecipe(context, allRecipes);
        }
      },
    );
  }

  List<Recipe> filterRecipes(List<Recipe> allRecipes, answers, currentQuestionIndex) {
    List<Recipe> filteredRecipes = [];
    print(filteredRecipes.length);
    for (var recipe in allRecipes) {
      print(recipe.title);
      print(recipe.timesCooked);
    }

    if (currentQuestionIndex == 0) {
      switch (answers[currentQuestionIndex]) {
        case CategoriesPreference.appetizers:
          filteredRecipes = allRecipes.where((recipe) => recipe.category == "Appetizers").toList();
        case CategoriesPreference.mainCourses:
          filteredRecipes = allRecipes.where((recipe) => recipe.category == "Main Courses").toList();
        case CategoriesPreference.sideDishes:
          filteredRecipes = allRecipes.where((recipe) => recipe.category == "Side Dishes").toList();
        case CategoriesPreference.salads:
          filteredRecipes = allRecipes.where((recipe) => recipe.category == "Salads").toList();
        case CategoriesPreference.sweetStuff:
          filteredRecipes = allRecipes.where((recipe) => recipe.category == "Sweet Stuff").toList();
        case CategoriesPreference.drinks:
          filteredRecipes = allRecipes.where((recipe) => recipe.category == "Drinks").toList();
          break;
      }
    } else if (currentQuestionIndex == 1) {
      switch (answers[currentQuestionIndex]) {
        case DifficultyPreference.simple:
          filteredRecipes = allRecipes.where((recipe) => recipe.difficulty == "Simple").toList();
        case DifficultyPreference.notTooTricky:
          filteredRecipes = allRecipes.where((recipe) => recipe.difficulty == "Not too tricky").toList();
        case DifficultyPreference.impressive:
          filteredRecipes = allRecipes.where((recipe) => recipe.difficulty == "Impressive").toList();
        case DifficultyPreference.irrelevant:
          break;
      }
    } else if (currentQuestionIndex == 2) {
      switch (answers[currentQuestionIndex]) {
        case TimePreference.little:
          filteredRecipes = allRecipes.where((recipe) => recipe.prepTime + recipe.cookingTime <= 30).toList();
        case TimePreference.medium:
          filteredRecipes = allRecipes.where((recipe) => recipe.prepTime + recipe.cookingTime <= 60).toList();
        case TimePreference.irrelevant:
          break;
      }
    } else if (currentQuestionIndex == 3) {
      final timesCookedList = allRecipes.map((recipe) => recipe.timesCooked).toList();
      if (timesCookedList.isNotEmpty) {
        timesCookedList.sort();
        print('times cooked: $timesCookedList');

        final top30PercentIndex = (timesCookedList.length * 0.7).floor();
        final threshold = timesCookedList[top30PercentIndex];

        switch (answers[currentQuestionIndex]) {
          case FamiliarityPreference.unfamiliar:
            filteredRecipes = allRecipes.where((recipe) => recipe.timesCooked == 0).toList();
          case FamiliarityPreference.familiar:
            filteredRecipes =
                allRecipes.where((recipe) => recipe.timesCooked > 0 && recipe.timesCooked < threshold).toList();
          case FamiliarityPreference.veryFamiliar:
            filteredRecipes = allRecipes.where((recipe) => recipe.timesCooked >= threshold).toList();
          case FamiliarityPreference.irrelevant:
            break;
        }
      }
    } else if (currentQuestionIndex == 4) {
      switch (answers[currentQuestionIndex]) {
        case FavoriteRecipePreference.onlyFavorites:
          filteredRecipes = allRecipes.where((recipe) => recipe.isFavorite == true).toList();
        case FavoriteRecipePreference.excludeFavorites:
          filteredRecipes = allRecipes.where((recipe) => recipe.isFavorite == false).toList();
        case FavoriteRecipePreference.irrelevant:
          break;
      }
    }

    return filteredRecipes;
  }
}
