import 'package:dishdrop_app_projekt/core/utils/show_custom_alert_banner.dart';
import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/models/shopping_list.dart';

import 'package:dishdrop_app_projekt/ui/widgets/ingredient_list_view.dart';
import 'package:dishdrop_app_projekt/ui/widgets/servings_picker.dart';
import 'package:flutter/material.dart';

class RecipeDetailsIngredientsSection extends StatefulWidget {
  const RecipeDetailsIngredientsSection({
    super.key,
    required this.recipe,
    required this.allShoppingLists,
    required this.addShoppingListFunc,
  });

  final Recipe recipe;

  final List<ShoppingList> allShoppingLists;
  final Function addShoppingListFunc;

  @override
  State<RecipeDetailsIngredientsSection> createState() => _RecipeDetailsIngredientsSectionState();
}

class _RecipeDetailsIngredientsSectionState extends State<RecipeDetailsIngredientsSection> {
  late int servings;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    servings = 1;
  }

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
            ServingsPicker(
              updateServingsFunc: updateServings,
              servings: servings,
            ),
            FilledButton(
              onPressed: () {
                if (widget.allShoppingLists.any((shoppingList) => shoppingList.id == widget.recipe.id)) {
                  showCustomAlertBanner(
                    context,
                    Colors.red,
                    "Recipe is already on the shopping list.",
                  );
                } else {
                  final newShoppingList = ShoppingList(
                    title: widget.recipe.title,
                    imgUrl: widget.recipe.images["titleImg"],
                    servings: servings,
                  );

                  newShoppingList.shoppingItems.addAll(widget.recipe.ingredients);

                  setState(() {
                    isLoading = true;
                  });
                  widget.addShoppingListFunc(newShoppingList);
                  setState(() {
                    isLoading = false;
                  });

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
              child: Text("Add to shoppings list"),
            ),
          ],
        ),
        SizedBox(height: 15),
        isLoading
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(child: CircularProgressIndicator()),
              )
            : IngredientListView(
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
