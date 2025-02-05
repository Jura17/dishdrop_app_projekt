import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/repositories/mock_database.dart';
import 'package:dishdrop_app_projekt/ui/screens/recipe_details_screen/recipe_details_screen.dart';
import 'package:dishdrop_app_projekt/ui/widgets/dismiss_button.dart';
import 'package:dishdrop_app_projekt/ui/widgets/like_button.dart';

import 'package:flutter/material.dart';

class RecommendationCard extends StatelessWidget {
  const RecommendationCard({
    super.key,
    required this.recipe,
    required this.db,
    required this.getRandomRecipeFunc,
  });

  final Recipe recipe;
  final MockDatabase db;
  final Function getRandomRecipeFunc;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Image.network(
                        errorBuilder: (context, error, stackTrace) => Center(
                          child: Text(
                            "404",
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        ),
                        recipe.images["titleImg"],
                        fit: BoxFit.cover,
                      ),
                    ),
                    LikeButton(
                      top: 20,
                      right: 20,
                      width: 60,
                      height: 60,
                      recipe: recipe,
                    ),
                    DismissButton(
                      top: 20,
                      left: 20,
                      width: 40,
                      height: 40,
                    ),
                  ],
                ),
              ),
              Expanded(
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
                                            recipe: recipe, db: db),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
