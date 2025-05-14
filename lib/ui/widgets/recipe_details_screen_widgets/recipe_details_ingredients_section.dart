import 'package:dishdrop_app_projekt/core/utils/show_custom_alert_banner.dart';
import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/models/shopping_list.dart';
import 'package:dishdrop_app_projekt/data/provider/recipe_notifier.dart';
import 'package:dishdrop_app_projekt/data/provider/shopping_list_notifier.dart';
import 'package:dishdrop_app_projekt/ui/screens/shopping_list_screen.dart';

import 'package:dishdrop_app_projekt/ui/widgets/ingredient_list_view.dart';
import 'package:dishdrop_app_projekt/ui/widgets/servings_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipeDetailsIngredientsSection extends StatefulWidget {
  const RecipeDetailsIngredientsSection(
      {super.key, required this.recipeId, required this.servingsInput, required this.updateServingsFunc});

  final int recipeId;
  final int servingsInput;
  final void Function(int) updateServingsFunc;

  @override
  State<RecipeDetailsIngredientsSection> createState() => _RecipeDetailsIngredientsSectionState();
}

class _RecipeDetailsIngredientsSectionState extends State<RecipeDetailsIngredientsSection> {
  late int servings;

  @override
  Widget build(BuildContext context) {
    servings = widget.servingsInput;

    final recipeNotifier = context.watch<RecipeNotifier>();
    final shoppingListNotifier = context.read<ShoppingListNotifier>();
    Recipe? recipe = recipeNotifier.getRecipeById(widget.recipeId);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Ingredients", style: Theme.of(context).textTheme.headlineMedium),
        SizedBox(height: 15),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ServingsPicker(
              updateServingsFunc: widget.updateServingsFunc,
              servings: servings,
            ),
            // Recipe already on the shopping lists? ==> go to Shopping list screen, otherwise create shopping list
            recipe != null && recipe.shoppingList.targetId != 0
                ? FilledButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ShoppingListScreen()),
                      );
                    },
                    style: Theme.of(context).filledButtonTheme.style,
                    child: Text("Go to shopping lists"),
                  )
                : FilledButton(
                    onPressed: () {
                      if (recipe != null) {
                        final newShoppingList = ShoppingList(
                          title: recipe.title,
                          imgUrl: recipe.images["titleImg"],
                          servings: servings,
                        );
                        newShoppingList.shoppingItems.addAll(recipe.ingredients);

                        recipeNotifier.assignShoppingListToRecipe(recipe, newShoppingList);
                        shoppingListNotifier.loadRecipeShoppingLists();

                        if (context.mounted) {
                          showCustomAlertBanner(
                            context,
                            Theme.of(context).primaryColor,
                            "Ingredients added to shopping list!",
                          );
                        }
                      }
                    },
                    style: Theme.of(context).filledButtonTheme.style,
                    child: Text("Add to shopping list"),
                  ),
          ],
        ),
        SizedBox(height: 15),
        if (recipe != null)
          IngredientListView(
            recipe: recipe,
            servings: servings,
          )
      ],
    );
  }
}
