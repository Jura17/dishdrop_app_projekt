import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
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
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Remove recipe?"),
                  content: RichText(
                    text: TextSpan(
                        style: Theme.of(context).textTheme.bodyLarge,
                        text: "Are you sure you want to remove ",
                        children: [
                          TextSpan(text: recipe.title, style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: " from your cookbook?"),
                        ]),
                  ),
                  actions: [
                    TextButton(
                      style: ButtonStyle(
                        foregroundColor: WidgetStateColor.resolveWith(
                          (states) => AppColors.dishDropBlack,
                        ),
                      ),
                      onPressed: () {
                        removeRecipe(shoppingListNotifier, recipeNotifier, context);
                      },
                      child: Text("Yes"),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        foregroundColor: WidgetStateColor.resolveWith(
                          (states) => AppColors.dishDropBlack,
                        ),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text("Cancel"),
                    ),
                  ],
                );
              },
            ).then((result) {
              if (result == true) Navigator.of(context).pop();
            });
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

  void removeRecipe(ShoppingListNotifier shoppingListNotifier, RecipeNotifier recipeNotifier, BuildContext context) {
    final shoppingList = recipe.shoppingList.target;
    if (shoppingList != null) {
      shoppingListNotifier.removeRecipeShoppingList(shoppingList);
      shoppingListNotifier.loadRecipeShoppingLists();
    }
    recipeNotifier.removeRecipe(recipe);
    showCustomAlertBanner(context, Colors.red, "Recipe removed from cookbook.");
    Navigator.pop(context, true);
  }
}
