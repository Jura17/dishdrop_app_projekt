import 'package:dishdrop_app_projekt/core/utils/show_custom_alert_banner.dart';
import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/models/shopping_list.dart';

import 'package:dishdrop_app_projekt/data/shopping_list_controller.dart';
import 'package:dishdrop_app_projekt/ui/widgets/ingredient_list_view.dart';
import 'package:dishdrop_app_projekt/ui/widgets/servings_picker.dart';
import 'package:flutter/material.dart';

class IngredientsSection extends StatelessWidget {
  const IngredientsSection(
      {super.key, required this.recipe, required this.shoppingListController});

  final Recipe recipe;
  final ShoppingListController shoppingListController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Ingredients", style: Theme.of(context).textTheme.headlineMedium),
        SizedBox(height: 15),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ServingsPicker(),
            FilledButton(
              onPressed: () {
                shoppingListController.addShoppingList(
                  ShoppingList(
                      title: recipe.title, shoppingItems: recipe.ingredients),
                );
                showCustomAlertBanner(
                  context,
                  Theme.of(context).primaryColor,
                  "Ingredients added to shopping list!",
                );
              },
              style: Theme.of(context).filledButtonTheme.style,
              child: Text("Add to shoppings list"),
            ),
          ],
        ),
        SizedBox(height: 15),
        IngredientListView(recipe: recipe)
      ],
    );
  }
}
