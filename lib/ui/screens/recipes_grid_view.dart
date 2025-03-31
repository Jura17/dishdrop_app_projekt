import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/recipe_controller.dart';
import 'package:dishdrop_app_projekt/data/shopping_list_controller.dart';
import 'package:dishdrop_app_projekt/ui/screens/recipe_form_screen.dart';

import 'package:dishdrop_app_projekt/ui/widgets/custom_filled_icon_button.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_card_widgets/recipe_card.dart';
import 'package:flutter/material.dart';

class RecipesGridView extends StatefulWidget {
  const RecipesGridView({
    super.key,
    required this.category,
    required this.recipeController,
    required this.shoppingListController,
    required this.allRecipes,
  });
  final String category;
  final RecipeController recipeController;
  final ShoppingListController shoppingListController;
  final List<Recipe> allRecipes;

  @override
  State<RecipesGridView> createState() => _RecipesGridViewState();
}

class _RecipesGridViewState extends State<RecipesGridView> {
  List<Recipe> filteredRecipes = [];

  @override
  void initState() {
    filteredRecipes = widget.allRecipes.where((recipe) => recipe.category == widget.category).toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category, style: Theme.of(context).textTheme.headlineLarge),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 64, left: 8, right: 8),
          child: Center(
            child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 0.6,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  ...filteredRecipes.map(
                    (recipe) => RecipeCard(
                      recipe: recipe,
                      recipeController: widget.recipeController,
                      shoppingListController: widget.shoppingListController,
                    ),
                  )
                ]),
          ),
        ),
      ),
      floatingActionButton: CustomFilledIconButton(
        text: "Add Recipe",
        iconData: Icons.add_box_outlined,
        recipeController: widget.recipeController,
        shoppingListController: widget.shoppingListController,
        newScreen: RecipeFormScreen(
          recipeController: widget.recipeController,
          shoppingListController: widget.shoppingListController,
          allRecipes: widget.allRecipes,
        ),
      ),
    );
  }
}
