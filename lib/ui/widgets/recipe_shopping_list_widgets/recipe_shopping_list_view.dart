import 'package:dishdrop_app_projekt/core/utils/show_custom_alert_banner.dart';
import 'package:dishdrop_app_projekt/data/models/shopping_list.dart';
import 'package:dishdrop_app_projekt/data/provider/shopping_list_notifier.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_shopping_list_widgets/recipe_shopping_list_items.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_shopping_list_widgets/recipe_shopping_list_title_image.dart';
import 'package:dishdrop_app_projekt/ui/widgets/servings_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipeShoppingListView extends StatelessWidget {
  const RecipeShoppingListView({
    super.key,
    required this.recipeShoppingList,
  });

  final ShoppingList recipeShoppingList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          recipeShoppingList.title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        SizedBox(height: 10),
        RecipeShoppingListTitleImage(recipeShoppingList: recipeShoppingList),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ServingsPicker(
              servings: recipeShoppingList.servings,
              updateServingsFunc: (newAmount) {
                final updatedShoppingList =
                    context.read<ShoppingListNotifier>().getRecipeShoppingListById(recipeShoppingList.id);

                if (updatedShoppingList != null) {
                  updatedShoppingList.servings = newAmount;
                  context.read<ShoppingListNotifier>().updateRecipeShoppingList(
                        updatedShoppingList.id,
                        updatedShoppingList,
                      );
                }
              },
            ),
            TextButton.icon(
              style: TextButton.styleFrom(foregroundColor: Colors.red, iconColor: Colors.red),
              onPressed: () {
                context.read<ShoppingListNotifier>().removeRecipeShoppingList(recipeShoppingList);
                context.read<ShoppingListNotifier>().loadRecipeShoppingLists();
                showCustomAlertBanner(context, Colors.red, "Ingredients removed from shopping list.");
              },
              label: Text("Remove from list"),
              icon: Icon(
                Icons.delete,
                size: 30,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text("Ingredients", style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 10),
        RecipeShoppingListItems(
          recipeShoppingList: recipeShoppingList,
          servings: recipeShoppingList.servings,
        ),
        SizedBox(height: 50)
      ],
    );
  }
}
