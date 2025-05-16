import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:dishdrop_app_projekt/core/utils/get_random_recipe.dart';
import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/provider/recipe_notifier.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecommendationButton extends StatelessWidget {
  const RecommendationButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<Recipe> allRecipes = context.watch<RecipeNotifier>().allRecipes;

    // return IconButton.filled(
    //   padding: EdgeInsets.all(25),
    //   onPressed: () => getRandomRecipe(context, allRecipes),
    //   icon: Icon(
    //     Icons.lightbulb_outline_rounded,
    //     size: 125,
    //   ),
    //   style: IconButton.styleFrom(backgroundColor: Theme.of(context).primaryColor),
    // );
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
      onPressed: () => getRandomRecipe(context, allRecipes),
    );
  }
}
