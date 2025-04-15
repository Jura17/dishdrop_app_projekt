import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';

import 'package:dishdrop_app_projekt/core/utils/show_custom_alert_banner.dart';
import 'package:dishdrop_app_projekt/data/models/shopping_list.dart';

import 'package:dishdrop_app_projekt/data/shopping_list_controller.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_shopping_list_view_widgets/recipe_shopping_list_is_empty_text.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_shopping_list_view_widgets/recipe_shopping_list_items.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_shopping_list_view_widgets/recipe_shopping_list_title_image.dart';
import 'package:dishdrop_app_projekt/ui/widgets/servings_picker.dart';
import 'package:flutter/material.dart';

class RecipeShoppingListView extends StatefulWidget {
  const RecipeShoppingListView({super.key, required this.shoppingListController});

  final ShoppingListController shoppingListController;

  @override
  State<RecipeShoppingListView> createState() => _RecipeShoppingListViewState();
}

class _RecipeShoppingListViewState extends State<RecipeShoppingListView> {
  int servings = 1;

  @override
  Widget build(BuildContext context) {
    List<ShoppingList> allRecipeShoppingLists = [];

    return Center(
      child: StreamBuilder(
        stream: widget.shoppingListController.getRecipeShoppingLists(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text("Error while fetching data: ${snapshot.error}");
          } else if (snapshot.data == null) {
            return Text("No data");
          }
          allRecipeShoppingLists = snapshot.data!.toList();
          return allRecipeShoppingLists.isEmpty
              ? RecipeShoppingListIsEmptyText()
              : RecipeShoppingListIngredientsSection(
                  allRecipeShoppingLists: allRecipeShoppingLists,
                  shoppingListController: widget.shoppingListController,
                  removeShoppingListFunc: removeShoppingList,
                );
        },
      ),
    );
  }

  // Future<void> removeShoppingList(ShoppingList shoppingList) async {
  //   // await widget.shoppingListController.removeShoppingListFuture(shoppingList);
  //   setState(() {});
  // }

  void removeShoppingList(ShoppingList shoppingList) {
    widget.shoppingListController.removeShoppingList(shoppingList);
  }
}

class RecipeShoppingListIngredientsSection extends StatefulWidget {
  const RecipeShoppingListIngredientsSection({
    super.key,
    required this.allRecipeShoppingLists,
    required this.shoppingListController,
    required this.removeShoppingListFunc,
  });

  final List<ShoppingList> allRecipeShoppingLists;
  final ShoppingListController shoppingListController;
  final Function removeShoppingListFunc;

  @override
  State<RecipeShoppingListIngredientsSection> createState() => _RecipeShoppingListIngredientsSectionState();
}

class _RecipeShoppingListIngredientsSectionState extends State<RecipeShoppingListIngredientsSection> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: widget.allRecipeShoppingLists.map((ShoppingList recipeShoppingList) {
            return RecipeShoppingListIngredientListView(
              recipeShoppingList: recipeShoppingList,
              shoppingListController: widget.shoppingListController,
              removeShoppingListFunc: widget.removeShoppingListFunc,
            );
          }).toList(),
        ),
      ),
    );
  }
}

class RecipeShoppingListIngredientListView extends StatefulWidget {
  const RecipeShoppingListIngredientListView({
    super.key,
    required this.recipeShoppingList,
    required this.shoppingListController,
    required this.removeShoppingListFunc,
  });

  final ShoppingList recipeShoppingList;
  final ShoppingListController shoppingListController;
  final Function removeShoppingListFunc;

  @override
  State<RecipeShoppingListIngredientListView> createState() => _RecipeShoppingListIngredientListViewState();
}

class _RecipeShoppingListIngredientListViewState extends State<RecipeShoppingListIngredientListView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.recipeShoppingList.title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        SizedBox(height: 10),
        RecipeShoppingListTitleImage(widget: widget),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ServingsPicker(
              updateServingsFunc: updateServings,
              servings: widget.recipeShoppingList.servings,
            ),
            TextButton.icon(
              style: TextButton.styleFrom(foregroundColor: Colors.red, iconColor: Colors.red),
              onPressed: () async {
                widget.removeShoppingListFunc(widget.recipeShoppingList);
                setState(
                  () {
                    showCustomAlertBanner(context, Colors.red, "Ingredients removed from shopping list.");
                  },
                );
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
        Text("Ingredients", style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 10),
        RecipeShoppingListItems(
          recipeShoppingList: widget.recipeShoppingList,
          servings: widget.recipeShoppingList.servings,
        ),
        SizedBox(height: 50)
      ],
    );
  }

  void updateServings(newAmount) {
    setState(() {
      widget.recipeShoppingList.servings = newAmount;
    });
  }
}
