import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';

import 'package:dishdrop_app_projekt/data/models/shopping_list.dart';

import 'package:dishdrop_app_projekt/ui/widgets/recipe_shopping_list_view_widgets/shopping_item_row_dismissable.dart';
import 'package:flutter/material.dart';

class RecipeShoppingListItems extends StatefulWidget {
  const RecipeShoppingListItems({
    super.key,
    required this.recipeShoppingList,
    required this.servings,
  });

  final ShoppingList recipeShoppingList;
  final int servings;

  @override
  State<RecipeShoppingListItems> createState() => _RecipeShoppingListItemsState();
}

class _RecipeShoppingListItemsState extends State<RecipeShoppingListItems> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.recipeShoppingList.shoppingItems.asMap().entries.map<Widget>((entry) {
        int innerIndex = entry.key;
        var shoppingItem = entry.value;

        return Container(
          color: innerIndex.isEven ? AppColors.lightGrey : Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ShoppingItemRowDismissable(
              amount: shoppingItem.amount != null ? shoppingItem.amount! * widget.servings : null,
              unit: shoppingItem.unit,
              description: shoppingItem.description,
              dismissItem: dismissItem,
              index: innerIndex,
              shoppingItem: shoppingItem,
              shoppingListId: widget.recipeShoppingList.id,
            ),
          ),
        );
      }).toList(),
    );
  }

  void dismissItem(int index) {
    widget.recipeShoppingList.shoppingItems.removeAt(index);
  }
}
