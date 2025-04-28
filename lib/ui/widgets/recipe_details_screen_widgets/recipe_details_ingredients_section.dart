import 'package:dishdrop_app_projekt/core/utils/show_custom_alert_banner.dart';
import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/models/shopping_list.dart';
import 'package:dishdrop_app_projekt/data/provider/recipe_notifier.dart';
import 'package:dishdrop_app_projekt/ui/screens/shopping_list_screen.dart';

import 'package:dishdrop_app_projekt/ui/widgets/ingredient_list_view.dart';
import 'package:dishdrop_app_projekt/ui/widgets/servings_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipeDetailsIngredientsSection extends StatefulWidget {
  const RecipeDetailsIngredientsSection({
    super.key,
    required this.recipeId,
  });

  final int recipeId;

  @override
  State<RecipeDetailsIngredientsSection> createState() => _RecipeDetailsIngredientsSectionState();
}

class _RecipeDetailsIngredientsSectionState extends State<RecipeDetailsIngredientsSection> {
  late int servings;

  @override
  void initState() {
    super.initState();
    servings = 1;
  }

  @override
  Widget build(BuildContext context) {
    final recipeNotifier = context.watch<RecipeNotifier>();
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
              updateServingsFunc: updateServings,
              servings: servings,
            ),
            // Recipe already on the shopping lists? ==> go to Shopping list screen, otherwise create shopping list

            recipe!.shoppingList.targetId != 0
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
                      final newShoppingList = ShoppingList(
                        title: recipe.title,
                        imgUrl: recipe.images["titleImg"],
                        servings: servings,
                      );
                      newShoppingList.shoppingItems.addAll(recipe.ingredients);

                      recipeNotifier.assignShoppingListToRecipe(recipe, newShoppingList);

                      if (context.mounted) {
                        showCustomAlertBanner(
                          context,
                          Theme.of(context).primaryColor,
                          "Ingredients added to shopping list!",
                        );
                      }
                    },
                    style: Theme.of(context).filledButtonTheme.style,
                    child: Text("Add to shopping list"),
                  ),
          ],
        ),
        SizedBox(height: 15),
        IngredientListView(
          recipe: recipe,
          servings: servings,
        )
      ],
    );
  }

  void updateServings(newAmount) {
    setState(() {
      servings = newAmount;
    });
  }
}
