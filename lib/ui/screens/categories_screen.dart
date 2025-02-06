import 'package:dishdrop_app_projekt/data/recipe_controller.dart';

import 'package:dishdrop_app_projekt/data/shopping_list_controller.dart';
import 'package:dishdrop_app_projekt/gen/assets.gen.dart';
import 'package:dishdrop_app_projekt/ui/screens/new_recipe_screen.dart';

import 'package:dishdrop_app_projekt/ui/widgets/category_card.dart';
import 'package:dishdrop_app_projekt/ui/widgets/custom_filled_icon_button.dart';

import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
    required this.recipeController,
    required this.shoppingListController,
  });

  final RecipeController recipeController;
  final ShoppingListController shoppingListController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Categories",
            style: Theme.of(context).textTheme.headlineLarge),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: GridView.count(
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              CategoryCard(
                categoryImg: Assets.images.appetizersCategoryImg.path,
                categoryTitle: "Appetizers",
                recipeController: recipeController,
                shoppingListController: shoppingListController,
              ),
              CategoryCard(
                categoryImg: Assets.images.mainCoursesCategoryImg.path,
                categoryTitle: "Main Courses",
                recipeController: recipeController,
                shoppingListController: shoppingListController,
              ),
              CategoryCard(
                categoryImg: Assets.images.sideDishesCategoryImg.path,
                categoryTitle: "Side Dishes",
                recipeController: recipeController,
                shoppingListController: shoppingListController,
              ),
              CategoryCard(
                categoryImg: Assets.images.salatCategoryImg.path,
                categoryTitle: "Salads",
                recipeController: recipeController,
                shoppingListController: shoppingListController,
              ),
              CategoryCard(
                categoryImg: Assets.images.sweetStuffCategoryImg.path,
                categoryTitle: "Sweet Stuff",
                recipeController: recipeController,
                shoppingListController: shoppingListController,
              ),
              CategoryCard(
                categoryImg: Assets.images.drinksCategoryImg.path,
                categoryTitle: "Drinks",
                recipeController: recipeController,
                shoppingListController: shoppingListController,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: CustomFilledIconButton(
        text: "Add Recipe",
        iconData: Icons.add_box_outlined,
        recipeController: recipeController,
        shoppingListController: shoppingListController,
        newScreen: NewRecipeScreen(
            recipeController: recipeController,
            shoppingListController: shoppingListController),
      ),
    );
  }
}
