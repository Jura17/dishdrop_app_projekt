import 'package:dishdrop_app_projekt/core/utils/show_custom_alert_banner.dart';
import 'package:dishdrop_app_projekt/data/models/recipe.dart';

import 'package:dishdrop_app_projekt/data/recipe_controller.dart';
import 'package:dishdrop_app_projekt/data/shopping_list_controller.dart';
import 'package:dishdrop_app_projekt/ui/screens/edit_recipe_screen.dart';
import 'package:dishdrop_app_projekt/ui/screens/new_recipe_screen.dart';

import 'package:dishdrop_app_projekt/ui/widgets/recipe_details_screen_widgets/description_section.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_details_screen_widgets/directions_section.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_details_screen_widgets/ingredients_section.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_details_screen_widgets/quick_info_section.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_details_screen_widgets/recipe_details_title_image.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_details_screen_widgets/tags_section.dart';

import 'package:dishdrop_app_projekt/ui/widgets/custom_filled_icon_button.dart';

import 'package:flutter/material.dart';

class RecipeDetailsScreen extends StatefulWidget {
  const RecipeDetailsScreen({
    super.key,
    required this.recipe,
    required this.recipeController,
    required this.shoppingListController,
  });
  final Recipe recipe;
  final RecipeController recipeController;
  final ShoppingListController shoppingListController;

  @override
  State<RecipeDetailsScreen> createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  double defaultSpacing = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          child: Text(widget.recipe.title,
              style: Theme.of(context).textTheme.headlineLarge),
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 16, bottom: 80, left: 16, right: 16),
        child: ListView(
          children: [
            RecipeDetailsTitleImage(widget: widget),
            SizedBox(height: defaultSpacing),
            QuickInfoSection(widget: widget),
            SizedBox(height: defaultSpacing),
            if (widget.recipe.tags.isNotEmpty)
              TagsSection(recipe: widget.recipe),
            SizedBox(height: defaultSpacing),
            Align(
              alignment: Alignment.centerRight,
              child: FilledButton(
                onPressed: () {},
                // TODO: find a way to get the index of the ingredient section and scroll to its position
                child: Text("Jump to recipe"),
              ),
            ),
            SizedBox(height: defaultSpacing),
            if (widget.recipe.description != "")
              DescriptionSection(recipe: widget.recipe),
            SizedBox(height: defaultSpacing),
            if (widget.recipe.directions.isNotEmpty)
              DirectionsSection(recipe: widget.recipe),
            SizedBox(height: defaultSpacing),
            if (widget.recipe.ingredients.isNotEmpty)
              IngredientsSection(
                  recipe: widget.recipe,
                  shoppingListController: widget.shoppingListController),
            SizedBox(height: 40),
            RichText(
              text: TextSpan(
                text: "You have cooked this dish ",
                style: Theme.of(context).textTheme.bodyLarge,
                children: [
                  TextSpan(
                    text: "${widget.recipe.timesCooked}",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                      text:
                          " times so far.\nTap the button below when you're done!")
                ],
              ),
            ),
            SizedBox(height: 20),
            buildFooterButtonSection(context),
            SizedBox(height: 130),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 10,
        children: [
          CustomFilledIconButton(
            text: "Edit Recipe",
            iconData: Icons.edit,
            recipeController: widget.recipeController,
            shoppingListController: widget.shoppingListController,
            newScreen: EditRecipeScreen(
                recipeController: widget.recipeController,
                shoppingListController: widget.shoppingListController),
          ),
          CustomFilledIconButton(
            text: "Add Recipe",
            iconData: Icons.add_box_outlined,
            recipeController: widget.recipeController,
            shoppingListController: widget.shoppingListController,
            newScreen: NewRecipeScreen(
                recipeController: widget.recipeController,
                shoppingListController: widget.shoppingListController),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Column buildFooterButtonSection(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 30,
      children: [
        FilledButton.icon(
          icon: Icon(Icons.check),
          onPressed: () {
            setState(() {
              widget.recipe.timesCooked++;
            });
          },
          label: Text("I'm done cooking!"),
        ),
        TextButton.icon(
          style: TextButton.styleFrom(
              foregroundColor: Colors.red, iconColor: Colors.red),
          onPressed: () {
            int id =
                widget.recipeController.getAllRecipes().indexOf(widget.recipe);
            setState(() {
              widget.recipeController.removeRecipe(id);
              showCustomAlertBanner(
                  context, Colors.red, "Recipe removed from cookbook.");
            });
            Navigator.of(context).pop();
          },
          label: Text("Remove recipe"),
          icon: Icon(
            Icons.delete,
            size: 30,
          ),
        ),
      ],
    );
  }
}
