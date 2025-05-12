import 'package:dishdrop_app_projekt/data/models/shopping_list.dart';
import 'package:dishdrop_app_projekt/data/provider/shopping_list_notifier.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_shopping_list_widgets/recipe_shopping_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipeShoppingListsScrollView extends StatelessWidget {
  const RecipeShoppingListsScrollView({
    super.key,
  });

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
                return RecipeShoppingListView(
                  key: Key(recipeShoppingList.id.toString()),
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
