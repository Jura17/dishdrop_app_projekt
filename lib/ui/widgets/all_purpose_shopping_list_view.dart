import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:dishdrop_app_projekt/data/models/shopping_list.dart';

import 'package:dishdrop_app_projekt/data/shopping_list_controller.dart';
import 'package:flutter/material.dart';

class AllPurposeShoppingListView extends StatefulWidget {
  const AllPurposeShoppingListView(
      {super.key, required this.shoppingListController});

  final ShoppingListController shoppingListController;

  @override
  State<AllPurposeShoppingListView> createState() =>
      _AllPurposeShoppingListViewState();
}

class _AllPurposeShoppingListViewState
    extends State<AllPurposeShoppingListView> {
  @override
  Widget build(BuildContext context) {
    ShoppingList allPurposeShoppingList =
        widget.shoppingListController.getAllShoppingLists().first;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: List.generate(
                  allPurposeShoppingList.shoppingItems.length, (index) {
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
                          "${allPurposeShoppingList.shoppingItems[index].amount?.toString() ?? ''} ${allPurposeShoppingList.shoppingItems[index].unit?.toString() ?? ''}",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Expanded(
                          child: Text(
                            allPurposeShoppingList
                                .shoppingItems[index].description,
                            style: Theme.of(context).textTheme.bodyLarge,
                            textAlign: TextAlign.right,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
