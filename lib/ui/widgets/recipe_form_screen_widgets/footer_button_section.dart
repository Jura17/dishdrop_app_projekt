import 'dart:convert';

import 'package:dishdrop_app_projekt/core/utils/show_custom_alert_banner.dart';
import 'package:dishdrop_app_projekt/data/models/cooking_direction.dart';
import 'package:dishdrop_app_projekt/data/models/list_item.dart';
import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/ui/screens/recipe_form_screen.dart';
import 'package:dishdrop_app_projekt/ui/screens/recipe_details_screen.dart';
import 'package:flutter/material.dart';

class FooterButtonSection extends StatelessWidget {
  const FooterButtonSection({
    super.key,
    required this.complexInputValues,
    required this.widget,
    required this.allTextFormCtrl,
    required this.formKey,
    required this.checkNoneTextFieldValuesFunc,
    required this.resetAllCtrl,
    required this.isEditingRecipe,
  });

  final Map<String, dynamic> complexInputValues;

  final RecipeFormScreen widget;
  final Map<String, TextEditingController> allTextFormCtrl;
  final GlobalKey<FormState> formKey;
  final Function checkNoneTextFieldValuesFunc;
  final Function resetAllCtrl;
  final bool isEditingRecipe;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        FilledButton(
          onPressed: () async {
            if (formKey.currentState!.validate() && checkNoneTextFieldValuesFunc(allTextFormCtrl, complexInputValues)) {
              Recipe newRecipe = createRecipe(complexInputValues, allTextFormCtrl, isEditingRecipe);

              if (isEditingRecipe) {
                if (widget.recipe != null) {
                  widget.recipeController.updateRecipe(widget.recipe!, newRecipe);
                } else {
                  return;
                }
              } else {
                widget.recipeController.addRecipe(newRecipe);
              }

              resetAllCtrl(allTextFormCtrl, null);
              if (context.mounted) {
                showCustomAlertBanner(
                    context, Colors.green, isEditingRecipe ? "Recipe was edited!" : "Recipe added to cookbook!");
              }
            } else {
              showCustomAlertBanner(context, Colors.red, "Please make sure all fields are filled in correctly.");
            }
          },
          child: Text(isEditingRecipe ? "Update recipe" : "Save recipe"),
        ),
        FilledButton(
          onPressed: () async {
            if (formKey.currentState!.validate() && checkNoneTextFieldValuesFunc(allTextFormCtrl, complexInputValues)) {
              Recipe newRecipe = createRecipe(complexInputValues, allTextFormCtrl, isEditingRecipe);
              if (isEditingRecipe) {
                if (widget.recipe != null) {
                  widget.recipeController.updateRecipe(widget.recipe!, newRecipe);
                } else {
                  return;
                }
              } else {
                widget.recipeController.addRecipe(newRecipe);
              }

              resetAllCtrl(allTextFormCtrl, null);
              if (context.mounted) {
                showCustomAlertBanner(
                    context, Colors.green, isEditingRecipe ? "Recipe was edited!" : "Recipe added to cookbook!");
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) => RecipeDetailsScreen(
                      recipe: newRecipe,
                      recipeController: widget.recipeController,
                      shoppingListController: widget.shoppingListController,
                    ),
                  ),
                );
              }
            } else {
              showCustomAlertBanner(context, Colors.red, "Please make sure all fields are filled in correctly.");
            }
          },
          child: Text(isEditingRecipe ? "Update and open" : "Save and open"),
        )
      ],
    );
  }

  Recipe createRecipe(
      Map<String, dynamic> complexInputValues, Map<String, TextEditingController> allTextFormCtrl, isEditingRecipe) {
    final String title = allTextFormCtrl["titleCtrl"]!.text;
    final String category = allTextFormCtrl["categoryCtrl"]!.text;
    final String description = allTextFormCtrl["descCtrl"]?.text ?? "";
    final String notes = allTextFormCtrl["notesCtrl"]?.text ?? "";
    final String difficulty = allTextFormCtrl["difficultyCtrl"]!.text;
    final Map<String, dynamic> imagesInput = complexInputValues["images"];

    final List<String> tags = complexInputValues["tags"];
    final int prepTime = int.tryParse(allTextFormCtrl["prepTimeCtrl"]!.text) ?? 0;
    final int cookingTime = int.tryParse(allTextFormCtrl["cookingTimeCtrl"]!.text) ?? 0;
    final List<CookingDirection> directions = complexInputValues["directions"] as List<CookingDirection>;
    final List<ListItem> ingredients = complexInputValues["ingredients"] as List<ListItem>;

    // final recipeID = isEditingRecipe ? widget.recipe?.id : Uuid().v4();

    Recipe newRecipe = Recipe(
      // id: recipeID,
      title: title,
      category: category,
      description: description,
      notes: notes,
      difficulty: difficulty,
      tags: tags,
      imagesJson: jsonEncode(imagesInput),
      prepTime: prepTime,
      cookingTime: cookingTime,
    );

    newRecipe.directions.addAll(directions);
    newRecipe.ingredients.addAll(ingredients);

    return newRecipe;
  }
}
