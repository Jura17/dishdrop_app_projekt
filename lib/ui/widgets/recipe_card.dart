import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:flutter/material.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard({super.key, required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          // border: Border.all(color: AppColors.dishDropBlack),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image(
                fit: BoxFit.cover,
                image: AssetImage(recipe.images["titleImg"]),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.all(Radius.circular(20)),
                color: AppColors.lightGrey,
              ),
              height: 100,
              width: double.infinity,
              child: Column(
                children: [
                  Text(
                    recipe.title,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Row(
                    spacing: 4,
                    children: [
                      Icon(
                        Icons.timer_outlined,
                        size: 20,
                      ),
                      Text("${recipe.prepTime + recipe.cookTime} min")
                    ],
                  ),
                  Row(
                    spacing: 4,
                    children: [
                      Icon(
                        Icons.workspace_premium_sharp,
                        size: 20,
                      ),
                      Text(recipe.difficulty)
                    ],
                  ),
                  Row(
                    spacing: 4,
                    children: [
                      Icon(
                        Icons.check_circle_outline_outlined,
                        size: 20,
                      ),
                      Text("Cooked ${recipe.timesCooked} times")
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
