import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:dishdrop_app_projekt/ui/screens/recipe_details_screen.dart';
import 'package:dishdrop_app_projekt/ui/widgets/like_button.dart';
import 'package:flutter/material.dart';

class RecipeDetailsTitleImage extends StatelessWidget {
  const RecipeDetailsTitleImage({
    super.key,
    required this.widget,
  });

  final RecipeDetailsScreen widget;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.dishDropBlack),
          ),
          height: 300,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              errorBuilder: (context, error, stackTrace) => Center(
                  child: Text(
                "404",
                style: Theme.of(context).textTheme.headlineLarge,
              )),
              widget.recipe.images["titleImg"],
              fit: BoxFit.cover,
            ),
          ),
        ),
        LikeButton(
          top: 20,
          right: 20,
          width: 60,
          height: 60,
          recipe: widget.recipe,
        )
      ],
    );
  }
}
