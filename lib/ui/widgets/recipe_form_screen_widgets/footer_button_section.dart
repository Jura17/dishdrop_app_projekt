import 'dart:convert';

import 'package:dishdrop_app_projekt/core/utils/show_custom_alert_banner.dart';
import 'package:dishdrop_app_projekt/data/models/cooking_direction.dart';
import 'package:dishdrop_app_projekt/data/models/list_item.dart';
import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/provider/recipe_form_notifier.dart';
import 'package:dishdrop_app_projekt/data/provider/recipe_notifier.dart';

import 'package:dishdrop_app_projekt/ui/screens/recipe_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FooterButtonSection extends StatelessWidget {
  const FooterButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    final recipeFormProvider = context.watch<RecipeFormNotifier>();

    return Row(
      spacing: 10,
      children: [
        FilledButton(
          onPressed: () async {
            if (recipeFormProvider.formKey.currentState!.validate() && recipeFormProvider.checkNoneTextfieldValues()) {
              Recipe newRecipe = createRecipe(
                recipeFormProvider.complexInputValues,
                recipeFormProvider.allTextControllers,
                recipeFormProvider.isEditingRecipe,
              );

              if (recipeFormProvider.isEditingRecipe) {
                // UPDATE NEW RECIPE
                if (recipeFormProvider.recipe != null) {
                  context.read<RecipeNotifier>().updateRecipe(recipeFormProvider.recipe!.id, newRecipe);
                } else {
                  return;
                }
              } else {
                // CREATE NEW RECIPE
                context.read<RecipeNotifier>().addRecipe(newRecipe);
                recipeFormProvider.resetAllCtrl();
              }

              if (context.mounted) {
                showCustomAlertBanner(context, Colors.green,
                    recipeFormProvider.isEditingRecipe ? "Recipe was edited!" : "Recipe added to cookbook!");
              }
            } else {
              showCustomAlertBanner(context, Colors.red, "Please make sure all fields are filled in correctly.");
            }
          },
          child: Text(recipeFormProvider.isEditingRecipe ? "Update recipe" : "Save recipe"),
        ),
        FilledButton(
          onPressed: () async {
            if (recipeFormProvider.formKey.currentState!.validate() && recipeFormProvider.checkNoneTextfieldValues()) {
              Recipe newRecipe = createRecipe(
                recipeFormProvider.complexInputValues,
                recipeFormProvider.allTextControllers,
                recipeFormProvider.isEditingRecipe,
              );
              if (recipeFormProvider.isEditingRecipe) {
                // UPDATE NEW RECIPE
                if (recipeFormProvider.recipe != null) {
                  context.read<RecipeNotifier>().updateRecipe(recipeFormProvider.recipe!.id, newRecipe);
                } else {
                  return;
                }
              } else {
                // CREATE NEW RECIPE
                context.read<RecipeNotifier>().addRecipe(newRecipe);
              }

              recipeFormProvider.resetAllCtrl();
              if (context.mounted) {
                showCustomAlertBanner(context, Colors.green,
                    recipeFormProvider.isEditingRecipe ? "Recipe was edited!" : "Recipe added to cookbook!");
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) => RecipeDetailsScreen(
                      recipeId: recipeFormProvider.isEditingRecipe && recipeFormProvider.recipe != null
                          ? recipeFormProvider.recipe!.id
                          : newRecipe.id,
                    ),
                  ),
                );
              }
            } else {
              showCustomAlertBanner(context, Colors.red, "Please make sure all fields are filled in correctly.");
            }
          },
          child: Text(recipeFormProvider.isEditingRecipe ? "Update and open" : "Save and open"),
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
