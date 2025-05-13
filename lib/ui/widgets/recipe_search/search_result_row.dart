import 'package:dishdrop_app_projekt/ui/widgets/recipe_search/search_result_image.dart';
import 'package:flutter/material.dart';

class SearchResultRow extends StatelessWidget {
  const SearchResultRow({
    super.key,
    required this.recipeTitle,
    required this.imageWidget,
  });

  final String recipeTitle;
  final SearchResultImage imageWidget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          recipeTitle,
          overflow: TextOverflow.fade,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
        ),
        imageWidget,
      ],
    );
  }
}
