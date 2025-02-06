import 'package:dishdrop_app_projekt/ui/screens/recipe_details_screen.dart';
import 'package:flutter/material.dart';

class QuickInfoSection extends StatelessWidget {
  const QuickInfoSection({
    super.key,
    required this.widget,
  });

  final RecipeDetailsScreen widget;

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
              "${widget.recipe.prepTime + widget.recipe.cookingTime} min (Prep: ${widget.recipe.prepTime} min, Cook: ${widget.recipe.cookingTime} min)",
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
              widget.recipe.difficulty,
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
            RichText(
              text: TextSpan(
                text: "Cooked ",
                style: Theme.of(context).textTheme.bodyLarge,
                children: [
                  TextSpan(
                    text: "${widget.recipe.timesCooked}",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: " times")
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
