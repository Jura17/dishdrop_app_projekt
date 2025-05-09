import 'package:dishdrop_app_projekt/core/utils/show_custom_alert_banner.dart';
import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/provider/recipe_notifier.dart';
import 'package:dishdrop_app_projekt/data/provider/shopping_list_notifier.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipeDetailsFooterButtonSection extends StatelessWidget {
  const RecipeDetailsFooterButtonSection({
    super.key,
    required this.recipe,
  });

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    final shoppingListNotifier = context.read<ShoppingListNotifier>();
    final recipeNotifier = context.read<RecipeNotifier>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 30,
      children: [
        FilledButton.icon(
          icon: Icon(Icons.check),
          onPressed: () {
            recipe.updateCounterTimesCooked();
            recipeNotifier.updateRecipe(recipe.id, recipe);
          },
          label: Text("I'm done cooking!"),
        ),
        TextButton.icon(
          style: TextButton.styleFrom(foregroundColor: Colors.red, iconColor: Colors.red),
          onPressed: () {
            final shoppingList = recipe.shoppingList.target;
            if (shoppingList != null) {
              shoppingListNotifier.removeRecipeShoppingList(shoppingList);
              shoppingListNotifier.loadRecipeShoppingLists();
            }
            recipeNotifier.removeRecipe(recipe);
            showCustomAlertBanner(context, Colors.red, "Recipe removed from cookbook.");
            Navigator.of(context).pop();
          },
          label: Text("Remove recipe"),
          icon: Icon(
            Icons.delete,
            size: 30,
          ),
        ),
      ],
    );
  }
}
