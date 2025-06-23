import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';

import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/models/shopping_list.dart';
import 'package:dishdrop_app_projekt/data/provider/recipe_notifier.dart';
import 'package:dishdrop_app_projekt/data/provider/shopping_list_notifier.dart';

import 'package:dishdrop_app_projekt/ui/widgets/recipe_details_screen_widgets/ingredient_list_view.dart';
import 'package:dishdrop_app_projekt/ui/widgets/servings_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Text("Ingredients", style: Theme.of(context).textTheme.headlineMedium)),
        SizedBox(height: 15),
        ServingsPicker(
          updateServingsFunc: widget.updateServingsFunc,
          servings: servings,
        ),

        // Recipe already on the shopping lists? ==> go to Shopping list screen, otherwise create shopping list
        recipe != null && recipe.shoppingList.targetId != 0
            ? FilledButton.icon(
                icon: Icon(Icons.shopping_cart),
                onPressed: () => context.push('/shopping-list'),
                style: Theme.of(context).filledButtonTheme.style,
                label: Text("Go to shopping lists"),
              )
            : FittedBox(
                child: FilledButton.icon(
                  icon: Icon(Icons.shopping_cart),
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
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Ingredients added to shopping list!"),
                            backgroundColor: AppColors.primary,
                          ),
                        );
                      }
                    }
                  },
                  style: Theme.of(context).filledButtonTheme.style,
                  label: Text("Add to shopping list"),
                ),
              ),
        SizedBox(height: 30),
        if (recipe != null)
          IngredientListView(
            recipe: recipe,
            servings: servings,
          )
      ],
    );
  }
}
