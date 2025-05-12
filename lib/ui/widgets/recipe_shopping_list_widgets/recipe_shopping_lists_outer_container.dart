import 'package:dishdrop_app_projekt/data/provider/shopping_list_notifier.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_shopping_list_widgets/recipe_shopping_lists_scroll_view.dart';

import 'package:dishdrop_app_projekt/ui/widgets/recipe_shopping_list_widgets/recipe_shopping_list_empty_text.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipeShoppingListsOuterContainer extends StatelessWidget {
  const RecipeShoppingListsOuterContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final shoppingListNotifier = context.watch<ShoppingListNotifier>();

    return Center(
      child: shoppingListNotifier.recipeShoppingLists.isEmpty
          ? RecipeShoppingListEmptyText()
          : RecipeShoppingListsScrollView(),
    );
  }
}
