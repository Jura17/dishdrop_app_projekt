import 'package:dishdrop_app_projekt/data/provider/recipe_form_notifier.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_form_screen_widgets/cooking_direction_row_dynamic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CookingDirectionsListView extends StatelessWidget {
  const CookingDirectionsListView({super.key});

  @override
  Widget build(BuildContext context) {
    final recipeFormProvider = context.watch<RecipeFormNotifier>();

    int counter = 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: recipeFormProvider.complexInputValues["directions"].map<Widget>(
        (cookingDirection) {
          counter++;

          return Container(
            key: Key(cookingDirection.tempID),
            child: CookingDirectionRowDynamic(
              cookingDirection: cookingDirection,
              rowIndex: counter,
            ),
          );
        },
      ).toList(),
    );
  }
}
