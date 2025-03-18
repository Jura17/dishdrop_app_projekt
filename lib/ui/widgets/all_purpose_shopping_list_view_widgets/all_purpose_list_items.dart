import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';

import 'package:dishdrop_app_projekt/data/models/shopping_list.dart';
import 'package:dishdrop_app_projekt/ui/widgets/list_item_row.dart';
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
          return Container(
            decoration: BoxDecoration(color: index.isEven ? AppColors.lightGrey : Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              // child: ListItemRow(
              //   amount: allPurposeShoppingList.shoppingItems[index].amount,
              //   unit: allPurposeShoppingList.shoppingItems[index].unit,
              //   description:
              //       allPurposeShoppingList.shoppingItems[index].description,

              // ),
            ),
          );
        },
      ),
    );
  }
}
