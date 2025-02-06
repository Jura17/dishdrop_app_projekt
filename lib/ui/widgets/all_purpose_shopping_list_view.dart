import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:dishdrop_app_projekt/core/utils/check_amount_and_convert.dart';
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
            Text(
              allPurposeShoppingList.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.dishDropBlack),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  allPurposeShoppingList.imgUrl,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
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
                          "${checkAmountAndConvert(allPurposeShoppingList.shoppingItems[index].amount)} ${allPurposeShoppingList.shoppingItems[index].unit?.toString() ?? ''}",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        // Text(
                        //   "${allPurposeShoppingList.shoppingItems[index].amount?.toString() ?? ''} ${allPurposeShoppingList.shoppingItems[index].unit?.toString() ?? ''}",
                        //   style: Theme.of(context).textTheme.bodyLarge,
                        // ),
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
            ),
            SizedBox(height: 100)
          ],
        ),
      ),
    );
  }
}
