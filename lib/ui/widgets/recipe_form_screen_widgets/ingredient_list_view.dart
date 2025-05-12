import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:dishdrop_app_projekt/data/provider/recipe_form_notifier.dart';

import 'package:dishdrop_app_projekt/ui/widgets/recipe_form_screen_widgets/ingredient_row_dynamic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IngredientListView extends StatelessWidget {
  const IngredientListView({super.key});

  @override
  Widget build(BuildContext context) {
    final recipeFormProvider = context.watch<RecipeFormNotifier>();
    int counter = 0;

    return Column(
      children: recipeFormProvider.complexInputValues["ingredients"].map<Widget>(
        (ingredient) {
          counter++;

          return Container(
            key: Key(ingredient.tempID),
            decoration: BoxDecoration(color: counter.isEven ? AppColors.lightGrey : Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IngredientRowDynamic(ingredient: ingredient),
            ),
          );
        },
      ).toList(),
    );
  }
}
