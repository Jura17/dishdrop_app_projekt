import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/provider/recipe_notifier.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuickInfoSection extends StatelessWidget {
  const QuickInfoSection({
    super.key,
    required this.recipe,
  });

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4,
      children: [
        Row(
          spacing: 4,
          children: [
            Icon(
              Icons.timer_outlined,
              size: 30,
            ),
            Text(
              "${recipe.prepTime + recipe.cookingTime} min (Prep: ${recipe.prepTime} min, Cook: ${recipe.cookingTime} min)",
              style: Theme.of(context).textTheme.bodyLarge,
            )
          ],
        ),
        Row(
          spacing: 4,
          children: [
            Icon(
              Icons.workspace_premium_sharp,
              size: 30,
            ),
            Text(
              recipe.difficulty,
              style: Theme.of(context).textTheme.bodyLarge,
            )
          ],
        ),
        Row(
          spacing: 4,
          children: [
            Icon(
              Icons.check_circle_outline_outlined,
              size: 30,
            ),
            Consumer<RecipeNotifier>(
              builder: (context, value, child) {
                return RichText(
                  text: TextSpan(
                    text: "Cooked ",
                    style: Theme.of(context).textTheme.bodyLarge,
                    children: [
                      TextSpan(
                        text: "${recipe.timesCooked}",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: " times")
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ],
    );
  }
}
