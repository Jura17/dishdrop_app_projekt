import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/recipe_controller.dart';
import 'package:dishdrop_app_projekt/data/shopping_list_controller.dart';
import 'package:dishdrop_app_projekt/ui/screens/recipe_details_screen.dart';
import 'package:flutter/material.dart';

class RecommendationCardInfoSection extends StatelessWidget {
  const RecommendationCardInfoSection({
    super.key,
    required this.recipe,
    required this.getRandomRecipeFunc,
    required this.recipeController,
    required this.shoppingListController,
  });

  final Recipe recipe;
  final Function getRandomRecipeFunc;
  final RecipeController recipeController;
  final ShoppingListController shoppingListController;

  @override
  Widget build(BuildContext context) {
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
                style: Theme.of(context)
                    .textTheme
                    .displaySmall
                    ?.copyWith(fontWeight: FontWeight.bold),
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
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontSize: 20),
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
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontSize: 20),
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
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontSize: 20),
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
                      getRandomRecipeFunc(context);
                    },
                    style: FilledButton.styleFrom(
                      side: BorderSide(color: AppColors.primary),
                      backgroundColor: AppColors.lightGreen,
                      foregroundColor: AppColors.primary,
                    ),
                    child: Text("Try again"),
                  ),
                  FilledButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              RecipeDetailsScreen(
                                  recipe: recipe,
                                  recipeController: recipeController,
                                  shoppingListController:
                                      shoppingListController),
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
