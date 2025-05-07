import 'package:dishdrop_app_projekt/core/utils/show_custom_alert_banner.dart';
import 'package:dishdrop_app_projekt/data/models/shopping_list.dart';
import 'package:dishdrop_app_projekt/data/provider/shopping_list_notifier.dart';

import 'package:dishdrop_app_projekt/ui/widgets/recipe_shopping_list_view_widgets/recipe_shopping_list_is_empty_text.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_shopping_list_view_widgets/recipe_shopping_list_items.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_shopping_list_view_widgets/recipe_shopping_list_title_image.dart';
import 'package:dishdrop_app_projekt/ui/widgets/servings_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipeShoppingListView extends StatelessWidget {
  const RecipeShoppingListView({super.key});

  @override
  Widget build(BuildContext context) {
    final shoppingListNotifier = context.watch<ShoppingListNotifier>();

    return Center(
      child: shoppingListNotifier.recipeShoppingLists.isEmpty
          ? RecipeShoppingListIsEmptyText()
          : RecipeShoppingListIngredientsSection(),
    );
  }
}

class RecipeShoppingListIngredientsSection extends StatefulWidget {
  const RecipeShoppingListIngredientsSection({
    super.key,
  });

  @override
  State<RecipeShoppingListIngredientsSection> createState() => _RecipeShoppingListIngredientsSectionState();
}

class _RecipeShoppingListIngredientsSectionState extends State<RecipeShoppingListIngredientsSection> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<ShoppingListNotifier>(
          builder: (context, shoppingListNotifier, child) {
            List<ShoppingList> allRecipeShoppingLists = shoppingListNotifier.recipeShoppingLists;
            return Column(
              children: allRecipeShoppingLists.map((ShoppingList recipeShoppingList) {
                return RecipeShoppingListIngredientListView(
                  recipeShoppingList: recipeShoppingList,
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}

class RecipeShoppingListIngredientListView extends StatefulWidget {
  const RecipeShoppingListIngredientListView({
    super.key,
    required this.recipeShoppingList,
  });

  final ShoppingList recipeShoppingList;

  @override
  State<RecipeShoppingListIngredientListView> createState() => _RecipeShoppingListIngredientListViewState();
}

class _RecipeShoppingListIngredientListViewState extends State<RecipeShoppingListIngredientListView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.recipeShoppingList.title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        SizedBox(height: 10),
        RecipeShoppingListTitleImage(widget: widget),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // TODO: bug that causes servings picker to show incorrect amount after deleting a shopping list above another
            ServingsPicker(
              updateServingsFunc: updateServings,
              servings: widget.recipeShoppingList.servings,
            ),
            TextButton.icon(
              style: TextButton.styleFrom(foregroundColor: Colors.red, iconColor: Colors.red),
              onPressed: () {
                context.read<ShoppingListNotifier>().removeShoppingList(widget.recipeShoppingList);
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
          recipeShoppingList: widget.recipeShoppingList,
          servings: widget.recipeShoppingList.servings,
        ),
        SizedBox(height: 50)
      ],
    );
  }

  void updateServings(newAmount) {
    widget.recipeShoppingList.servings = newAmount;
    context.read<ShoppingListNotifier>().updateShoppingList(widget.recipeShoppingList, widget.recipeShoppingList);
  }
}
