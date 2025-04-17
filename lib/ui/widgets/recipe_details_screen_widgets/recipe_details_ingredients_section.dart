import 'package:dishdrop_app_projekt/core/utils/show_custom_alert_banner.dart';
import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/models/shopping_list.dart';
import 'package:dishdrop_app_projekt/data/provider/recipe_notifier.dart';
import 'package:dishdrop_app_projekt/data/provider/shopping_list_notifier.dart';

import 'package:dishdrop_app_projekt/ui/widgets/ingredient_list_view.dart';
import 'package:dishdrop_app_projekt/ui/widgets/servings_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipeDetailsIngredientsSection extends StatefulWidget {
  const RecipeDetailsIngredientsSection({
    super.key,
    required this.recipe,
  });

  final Recipe recipe;

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
    final shoppingListNotifier = context.read<ShoppingListNotifier>();
    final recipeNotifier = context.watch<RecipeNotifier>();

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
            FilledButton(
              onPressed: () {
                if (widget.recipe.shoppingList.target != null) {
                  showCustomAlertBanner(
                    context,
                    Colors.red,
                    "Recipe is already on the shopping list.",
                  );
                  return;
                }

                final newShoppingList = ShoppingList(
                  title: widget.recipe.title,
                  imgUrl: widget.recipe.images["titleImg"],
                  servings: servings,
                );

                newShoppingList.shoppingItems.addAll(widget.recipe.ingredients);

                newShoppingList.recipe.target = widget.recipe;
                shoppingListNotifier.addShoppingList(newShoppingList);

                widget.recipe.shoppingList.target = newShoppingList;
                recipeNotifier.updateRecipe(widget.recipe, widget.recipe);

                print("Saved recipe.shoppingList.id: ${widget.recipe.shoppingList.target?.id}");
                print("Saved shoppingList.recipe.id: ${newShoppingList.recipe.target?.id}");

                if (context.mounted) {
                  showCustomAlertBanner(
                    context,
                    Theme.of(context).primaryColor,
                    "Ingredients added to shopping list!",
                  );
                }
              },
              style: Theme.of(context).filledButtonTheme.style,
              child: Text("Add to shoppings list"),
            ),
          ],
        ),
        SizedBox(height: 15),
        IngredientListView(
          recipe: widget.recipe,
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
