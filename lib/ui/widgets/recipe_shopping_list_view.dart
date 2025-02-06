import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:dishdrop_app_projekt/core/utils/show_custom_alert_banner.dart';
import 'package:dishdrop_app_projekt/data/models/shopping_list.dart';

import 'package:dishdrop_app_projekt/data/shopping_list_controller.dart';
import 'package:dishdrop_app_projekt/ui/widgets/servings_picker.dart';
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

    return allRecipeShoppingLists.isEmpty
        ? Center(
            child: Text(
              "Your shopping list is empty",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          )
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: allRecipeShoppingLists.map((recipeShoppingList) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recipeShoppingList.title,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.dishDropBlack),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            recipeShoppingList.imgUrl,
                            height: 250,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ServingsPicker(),
                          TextButton.icon(
                            style: TextButton.styleFrom(
                                foregroundColor: Colors.red,
                                iconColor: Colors.red),
                            onPressed: () {
                              int id = widget.shoppingListController
                                  .getAllShoppingLists()
                                  .indexOf(recipeShoppingList);
                              setState(() {
                                widget.shoppingListController
                                    .removeShoppingList(id);
                                showCustomAlertBanner(context, Colors.red,
                                    "Ingredients removed from shopping list.");
                              });
                            },
                            label: Text("Remove from list"),
                            icon: Icon(
                              Icons.delete,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text("Ingredients",
                          style: Theme.of(context).textTheme.headlineSmall),
                      const SizedBox(height: 10),
                      Column(
                        children: recipeShoppingList.shoppingItems
                            .asMap()
                            .entries
                            .map<Widget>((entry) {
                          int innerIndex = entry.key;
                          var shoppingItem = entry.value;

                          return Container(
                            color: innerIndex.isEven
                                ? AppColors.lightGrey
                                : Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                spacing: 10,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${shoppingItem.amount?.toString() ?? ''} ${shoppingItem.unit?.toString() ?? ''}",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      shoppingItem.description,
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 50)
                    ],
                  );
                }).toList(),
              ),
            ),
          );
  }
}
