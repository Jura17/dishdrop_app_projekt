import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:dishdrop_app_projekt/core/utils/check_amount_and_convert.dart';
import 'package:dishdrop_app_projekt/data/models/shopping_list.dart';
import 'package:flutter/material.dart';

class RecipeShoppingListItems extends StatelessWidget {
  const RecipeShoppingListItems({super.key, required this.recipeShoppingList});

  final ShoppingList recipeShoppingList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          recipeShoppingList.shoppingItems.asMap().entries.map<Widget>((entry) {
        int innerIndex = entry.key;
        var shoppingItem = entry.value;

        return Container(
          color: innerIndex.isEven ? AppColors.lightGrey : Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${checkAmountAndConvert(shoppingItem.amount)} ${shoppingItem.unit?.toString() ?? ''}",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                // Text(
                //   "${shoppingItem.amount?.toString() ?? ''} ${shoppingItem.unit?.toString() ?? ''}",
                //   style:
                //       Theme.of(context).textTheme.bodyLarge,
                // ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    shoppingItem.description,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
