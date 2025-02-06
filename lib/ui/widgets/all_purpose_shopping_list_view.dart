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

    // return Center(child: Text("All-purpose Shopping List"));

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            allPurposeShoppingList.title,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          ...allPurposeShoppingList.shoppingItems.map(
            (item) => Text(item.description),
          )
        ],
      ),
    );
  }
}
