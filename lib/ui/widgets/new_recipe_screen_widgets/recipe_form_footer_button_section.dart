import 'package:dishdrop_app_projekt/core/utils/show_custom_alert_banner.dart';
import 'package:dishdrop_app_projekt/data/models/list_item.dart';
import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/ui/screens/new_recipe_screen.dart';
import 'package:dishdrop_app_projekt/ui/screens/recipe_details_screen.dart';
import 'package:flutter/material.dart';

class RecipeFormFooterButtonSection extends StatelessWidget {
  const RecipeFormFooterButtonSection({
    super.key,
    required this.complexInputValues,
    required this.widget,
    required this.allTextFormCtrl,
    required this.formKey,
    required this.inputValuesValidFunc,
    required this.resetAllCtrl,
  });

  final Map<String, dynamic> complexInputValues;

  final NewRecipeScreen widget;
  final Map<String, TextEditingController> allTextFormCtrl;
  final GlobalKey<FormState> formKey;
  final Function inputValuesValidFunc;
  final Function resetAllCtrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        FilledButton(
          onPressed: () async {
            if (formKey.currentState!.validate() &&
                inputValuesValidFunc(allTextFormCtrl, complexInputValues)) {
              Recipe newRecipe =
                  createNewRecipe(complexInputValues, allTextFormCtrl);
              await widget.recipeController.addRecipeFuture(newRecipe);
              resetAllCtrl(allTextFormCtrl, null);
              showCustomAlertBanner(
                  context, Colors.green, "Recipe added to cookbook!");
            } else {
              showCustomAlertBanner(context, Colors.red,
                  "Please make sure all fields are filled correctly.");
            }
          },
          child: Text("Save recipe"),
        ),
        FilledButton(
          onPressed: () async {
            if (formKey.currentState!.validate() &&
                inputValuesValidFunc(allTextFormCtrl, complexInputValues)) {
              Recipe newRecipe =
                  createNewRecipe(complexInputValues, allTextFormCtrl);
              await widget.recipeController.addRecipeFuture(newRecipe);
              resetAllCtrl(allTextFormCtrl, null);
              showCustomAlertBanner(
                  context, Colors.green, "Recipe added to cookbook!");
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) => RecipeDetailsScreen(
                      recipe: newRecipe,
                      recipeController: widget.recipeController,
                      shoppingListController: widget.shoppingListController),
                ),
              );
            } else {
              showCustomAlertBanner(context, Colors.red,
                  "Please make sure all fields are filled correctly.");
            }
          },
          child: Text("Save and open recipe"),
        )
      ],
    );
  }

  Recipe createNewRecipe(Map<String, dynamic> complexInputValues,
      Map<String, TextEditingController> allTextFormCtrl) {
    final String title = allTextFormCtrl["titleCtrl"]!.text;
    final String category = allTextFormCtrl["categoryCtrl"]!.text;
    final String description = allTextFormCtrl["descCtrl"]?.text ?? "";
    final String notes = allTextFormCtrl["notesCtrl"]?.text ?? "";
    final String difficulty = allTextFormCtrl["difficultyCtrl"]!.text;
    final Map<String, dynamic> imagesInput = complexInputValues["images"];

    final List<String> tags = complexInputValues["tags"];
    final int prepTime =
        int.tryParse(allTextFormCtrl["prepTimeCtrl"]!.text) ?? 0;
    final int cookingTime =
        int.tryParse(allTextFormCtrl["cookingTimeCtrl"]!.text) ?? 0;
    final List<String> directions = complexInputValues["directions"];
    final List<ListItem> ingredients = complexInputValues["ingredients"];

    Recipe newRecipe = Recipe(
      title: title,
      category: category,
      description: description,
      notes: notes,
      difficulty: difficulty,
      tags: tags,
      images: imagesInput,
      prepTime: prepTime,
      cookingTime: cookingTime,
      directions: directions,
      ingredients: ingredients,
    );

    return newRecipe;
  }
}
