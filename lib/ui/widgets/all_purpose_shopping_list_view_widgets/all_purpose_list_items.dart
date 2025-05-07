import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:dishdrop_app_projekt/data/models/list_item.dart';

import 'package:dishdrop_app_projekt/data/models/shopping_list.dart';

import 'package:dishdrop_app_projekt/ui/widgets/all_purpose_shopping_list_view_widgets/shopping_item_row_dynamic.dart';
import 'package:flutter/material.dart';

class AllPurposeListItems extends StatelessWidget {
  const AllPurposeListItems({super.key, required this.allPurposeShoppingList});

  final ShoppingList allPurposeShoppingList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        allPurposeShoppingList.shoppingItems.length,
        (index) {
          ListItem ingredient = allPurposeShoppingList.shoppingItems[index];
          return Container(
            key: Key(ingredient.tempID),
            decoration: BoxDecoration(color: index.isEven ? AppColors.lightGrey : Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ShoppingItemRowDynamic(
                index: index,
                ingredient: allPurposeShoppingList.shoppingItems[index],
                dismissFromList: dismissFromList,
              ),
            ),
          );
        },
      ),
    );
  }

  void dismissFromList(id) {
    allPurposeShoppingList.shoppingItems.removeAt(id);
  }
}
