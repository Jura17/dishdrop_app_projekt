import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';

import 'package:dishdrop_app_projekt/core/utils/show_custom_alert_banner.dart';
import 'package:dishdrop_app_projekt/data/models/shopping_list.dart';

import 'package:dishdrop_app_projekt/data/shopping_list_controller.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_shopping_list_view_widgets/recipe_shopping_list_is_empty_text.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_shopping_list_view_widgets/recipe_shopping_list_items.dart';
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
      child: FutureBuilder(
        future: widget.shoppingListController.getAllShoppingListsFuture(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text("Error while fetching data: ${snapshot.error}");
          }
          allRecipeShoppingLists = snapshot.data!.skip(1).toList();
          return allRecipeShoppingLists.isEmpty
              ? RecipeShoppingListIsEmptyText()
              : IngredientsSection(
                  allRecipeShoppingLists: allRecipeShoppingLists,
                  shoppingListController: widget.shoppingListController,
                  removeShoppingListFunc: removeShoppingList,
                );
        },
      ),
    );
  }

  Future<void> removeShoppingList(ShoppingList shoppingList) async {
    await widget.shoppingListController.removeShoppingListFuture(shoppingList);
    setState(() {});
  }
}

class IngredientsSection extends StatefulWidget {
  const IngredientsSection({
    super.key,
    required this.allRecipeShoppingLists,
    required this.shoppingListController,
    required this.removeShoppingListFunc,
  });

  final List<ShoppingList> allRecipeShoppingLists;
  final ShoppingListController shoppingListController;
  final Function removeShoppingListFunc;

  @override
  State<IngredientsSection> createState() => _IngredientsSectionState();
}

class _IngredientsSectionState extends State<IngredientsSection> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: widget.allRecipeShoppingLists.map((ShoppingList recipeShoppingList) {
            return ShoppingListIngredientListView(
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

class ShoppingListIngredientListView extends StatefulWidget {
  const ShoppingListIngredientListView({
    super.key,
    required this.recipeShoppingList,
    required this.shoppingListController,
    required this.removeShoppingListFunc,
  });

  final ShoppingList recipeShoppingList;
  final ShoppingListController shoppingListController;
  final Function removeShoppingListFunc;

  @override
  State<ShoppingListIngredientListView> createState() => _ShoppingListIngredientListViewState();
}

class _ShoppingListIngredientListViewState extends State<ShoppingListIngredientListView> {
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
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.dishDropBlack),
            borderRadius: BorderRadius.circular(20),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              widget.recipeShoppingList.imgUrl,
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
