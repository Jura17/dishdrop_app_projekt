import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/ui/screens/recipe_details_screen.dart';
import 'package:dishdrop_app_projekt/ui/widgets/like_button.dart';
import 'package:flutter/material.dart';

class RecipeCard extends StatefulWidget {
  const RecipeCard({super.key, required this.recipe});

  final Recipe recipe;

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => RecipeDetailsScreen(recipe: widget.recipe)));
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.dishDropBlack),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
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
                          errorBuilder: (context, error, stackTrace) =>
                              Text("404"),
                          widget.recipe.images["titleImg"],
                          fit: BoxFit.cover,
                        ),
                      ),
                      LikeButton(
                        top: 10,
                        right: 10,
                        width: 40,
                        height: 40,
                        recipe: widget.recipe,
                      ),
                    ],
                  ),
                ),
                GreyRecipeInfoBox(recipe: widget.recipe)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GreyRecipeInfoBox extends StatelessWidget {
  const GreyRecipeInfoBox({
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
        children: [
          Text(
            recipe.title,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          Spacer(),
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
                    Text("${recipe.prepTime + recipe.cookTime} min")
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
