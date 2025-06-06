import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';

import 'package:dishdrop_app_projekt/data/models/recipe.dart';

import 'package:dishdrop_app_projekt/ui/widgets/recipe_form_screen_widgets/ingredient_row_static.dart';
import 'package:flutter/material.dart';

class IngredientListView extends StatefulWidget {
  const IngredientListView({
    super.key,
    required this.recipe,
    required this.servings,
  });

  final Recipe recipe;
  final int servings;

  @override
  State<IngredientListView> createState() => _IngredientListViewState();
}

class _IngredientListViewState extends State<IngredientListView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: List.generate(
            widget.recipe.ingredients.length,
            (index) {
              return Container(
                decoration: BoxDecoration(color: index.isEven ? AppColors.lightGrey : Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IngredientRowStatic(
                    amount: widget.recipe.ingredients[index].amount != null
                        ? widget.recipe.ingredients[index].amount! * widget.servings
                        : null,
                    unit: widget.recipe.ingredients[index].unit,
                    description: widget.recipe.ingredients[index].description,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
