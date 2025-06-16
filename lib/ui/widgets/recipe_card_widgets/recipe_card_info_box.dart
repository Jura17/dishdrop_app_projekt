import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:flutter/material.dart';

class RecipeCardInfoBox extends StatelessWidget {
  const RecipeCardInfoBox({
    super.key,
    required this.recipe,
  });

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
      ),
      height: 130,
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            recipe.title,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  spacing: 4,
                  children: [
                    Icon(
                      Icons.timer_outlined,
                      size: 22,
                    ),
                    Text("${recipe.prepTime + recipe.cookingTime} min")
                  ],
                ),
                Row(
                  spacing: 4,
                  children: [
                    Icon(
                      Icons.workspace_premium_sharp,
                      size: 22,
                    ),
                    Text(recipe.difficulty)
                  ],
                ),
                Row(
                  spacing: 4,
                  children: [
                    Icon(
                      Icons.check_circle_outline_outlined,
                      size: 22,
                    ),
                    Text("Cooked ${recipe.timesCooked} times")
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
