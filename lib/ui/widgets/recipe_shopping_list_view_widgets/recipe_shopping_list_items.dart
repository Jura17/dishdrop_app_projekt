import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';

import 'package:dishdrop_app_projekt/data/models/shopping_list.dart';

import 'package:dishdrop_app_projekt/ui/widgets/list_item_row_static.dart';
import 'package:flutter/material.dart';

class RecipeShoppingListItems extends StatelessWidget {
  const RecipeShoppingListItems({super.key, required this.recipeShoppingList});

  final ShoppingList recipeShoppingList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: recipeShoppingList.shoppingItems.asMap().entries.map<Widget>((entry) {
        int innerIndex = entry.key;
        var shoppingItem = entry.value;

        return Container(
          color: innerIndex.isEven ? AppColors.lightGrey : Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListItemRowStatic(
              amount: shoppingItem.amount,
              unit: shoppingItem.unit,
              description: shoppingItem.description,
            ),
          ),
        );
      }).toList(),
    );
  }
}
