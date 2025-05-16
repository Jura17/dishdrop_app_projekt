import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:dishdrop_app_projekt/core/utils/get_random_recipe.dart';
import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/provider/recipe_notifier.dart';

import 'package:dishdrop_app_projekt/ui/screens/recipe_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecommendationCardInfoSection extends StatelessWidget {
  const RecommendationCardInfoSection({
    super.key,
    required this.recipe,
  });

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    final List<Recipe> allRecipes = context.read<RecipeNotifier>().allRecipes;

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.lightGrey,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 4,
            children: [
              Text(
                recipe.title,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 5),
              Text(
                recipe.description,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Spacer(),
              Row(
                spacing: 4,
                children: [
                  Icon(
                    Icons.timer_outlined,
                    color: AppColors.dishDropBlack,
                    size: 30,
                  ),
                  Text(
                    "${recipe.prepTime + recipe.cookingTime} min",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 20),
                  )
                ],
              ),
              Row(
                spacing: 4,
                children: [
                  Icon(
                    Icons.workspace_premium_sharp,
                    color: AppColors.dishDropBlack,
                    size: 30,
                  ),
                  Text(
                    recipe.difficulty,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 20),
                  )
                ],
              ),
              Row(
                spacing: 4,
                children: [
                  Icon(
                    Icons.check_circle_outline_outlined,
                    color: AppColors.dishDropBlack,
                    size: 30,
                  ),
                  Text(
                    "Cooked ${recipe.timesCooked} times",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 20),
                  )
                ],
              ),
              SizedBox(height: 10),
              Row(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilledButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      getRandomRecipe(context, allRecipes);
                    },
                    style: FilledButton.styleFrom(
                      side: BorderSide(color: AppColors.primary),
                      backgroundColor: AppColors.lightGreen,
                      foregroundColor: AppColors.primary,
                    ),
                    child: Text("Look again"),
                  ),
                  FilledButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (BuildContext context) => RecipeDetailsScreen(
                            recipeId: recipe.id,
                          ),
                        ),
                      );
                    },
                    child: Text("Open recipe"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
