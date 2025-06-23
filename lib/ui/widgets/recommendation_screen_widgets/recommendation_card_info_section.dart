import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:dishdrop_app_projekt/core/utils/get_random_recipe.dart';
import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/provider/recipe_notifier.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RecommendationCardInfoSection extends StatelessWidget {
  const RecommendationCardInfoSection({
    super.key,
    required this.recipe,
  });

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    // When seeing the card we've already filtered through all recipes at least once, so use filtered list here
    final List<Recipe> recipes = context.read<RecipeNotifier>().filteredRecipes;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            spacing: 4,
            children: [
              FittedBox(
                child: Text(
                  recipe.title,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 5),
              Text(
                recipe.description,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 15),
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
                    // disable button if there is only 1 matching recipe
                    onPressed: recipes.length < 2
                        ? null
                        : () {
                            Navigator.of(context).pop();
                            getRandomRecipe(context, recipes);
                          },
                    style: recipes.length < 2
                        ? FilledButton.styleFrom(
                            backgroundColor: AppColors.darkGrey,
                            foregroundColor: AppColors.dishDropBlack,
                          )
                        : FilledButton.styleFrom(
                            side: BorderSide(color: AppColors.primary),
                            backgroundColor: AppColors.lightGreen,
                            foregroundColor: AppColors.primary,
                          ),
                    child: Text("Look again"),
                  ),
                  FilledButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      context.push('/categories/recipe-detail/${recipe.id}');
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
