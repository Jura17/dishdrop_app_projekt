import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';

import 'package:dishdrop_app_projekt/data/shopping_list_controller.dart';
import 'package:flutter/material.dart';

class RecipeShoppingListView extends StatefulWidget {
  const RecipeShoppingListView(
      {super.key, required this.shoppingListController});

  final ShoppingListController shoppingListController;

  @override
  State<RecipeShoppingListView> createState() => _RecipeShoppingListViewState();
}

class _RecipeShoppingListViewState extends State<RecipeShoppingListView> {
  @override
  Widget build(BuildContext context) {
    List allRecipeShoppingLists =
        widget.shoppingListController.getAllShoppingLists().skip(1).toList();

    return ListView.builder(
      itemCount: allRecipeShoppingLists.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          color: AppColors.lightGrey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    allRecipeShoppingLists[index].title,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  ...allRecipeShoppingLists[index].shoppingItems.map(
                        (item) => Text(item.description),
                      )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
