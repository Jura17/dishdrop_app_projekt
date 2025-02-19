import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:dishdrop_app_projekt/core/utils/check_amount_and_convert.dart';
import 'package:dishdrop_app_projekt/data/models/shopping_list.dart';
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
            decoration: BoxDecoration(
                color: index.isEven ? AppColors.lightGrey : Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${checkAmountAndConvert(allPurposeShoppingList.shoppingItems[index].amount)} ${allPurposeShoppingList.shoppingItems[index].unit?.toString() ?? ''}",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  // Text(
                  //   "${allPurposeShoppingList.shoppingItems[index].amount?.toString() ?? ''} ${allPurposeShoppingList.shoppingItems[index].unit?.toString() ?? ''}",
                  //   style: Theme.of(context).textTheme.bodyLarge,
                  // ),
                  Expanded(
                    child: Text(
                      allPurposeShoppingList.shoppingItems[index].description,
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.right,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
