import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_search/search_result_image.dart';
import 'package:flutter/material.dart';

class SearchResultRow extends StatelessWidget {
  const SearchResultRow({
    super.key,
    required this.recipe,
    required this.imageWidget,
  });

  final Recipe recipe;
  final SearchResultImage imageWidget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            spacing: 2,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                child: Text(
                  recipe.title,
                  overflow: TextOverflow.fade,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(height: 5),
              Row(
                spacing: 5,
                children: [
                  Icon(
                    Icons.timer_outlined,
                    color: AppColors.dishDropBlack,
                    size: 23,
                  ),
                  Text(
                    "${recipe.prepTime + recipe.cookingTime} min",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 17),
                  )
                ],
              ),
              Row(
                spacing: 5,
                children: [
                  Icon(
                    Icons.workspace_premium_sharp,
                    color: AppColors.dishDropBlack,
                    size: 23,
                  ),
                  Text(
                    recipe.difficulty,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 17),
                  )
                ],
              ),
              Row(
                spacing: 5,
                children: [
                  Icon(
                    Icons.check_circle_outline_outlined,
                    color: AppColors.dishDropBlack,
                    size: 23,
                  ),
                  Text(
                    "Cooked ${recipe.timesCooked} times",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 17),
                  )
                ],
              ),
            ],
          ),
        ),
        imageWidget,
      ],
    );
  }
}
