import 'package:dishdrop_app_projekt/core/utils/show_custom_alert_banner.dart';
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
  });

  final Map<String, dynamic> complexInputValues;

  final NewRecipeScreen widget;
  final Map<String, TextEditingController> allTextFormCtrl;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        FilledButton(
          onPressed: () {
            print(allTextFormCtrl["categoryCtrl"]?.text);
            if (formKey.currentState!.validate()) {
              Recipe newRecipe =
                  getCtrlInputValues(allTextFormCtrl, complexInputValues);
              widget.recipeController.addRecipe(newRecipe);
              showCustomAlertBanner(
                  context, Colors.green, "Recipe added to cookbook!");
            }
          },
          child: Text("Save recipe"),
        ),
        FilledButton(
          onPressed: () {
            Recipe newRecipe =
                getCtrlInputValues(allTextFormCtrl, complexInputValues);
            resetAllCtrl(allTextFormCtrl);
            widget.recipeController.addRecipe(newRecipe);
            showCustomAlertBanner(
                context, Colors.green, "Recipe added to cookbook!");
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => RecipeDetailsScreen(
                    recipe: newRecipe,
                    recipeController: widget.recipeController,
                    shoppingListController: widget.shoppingListController),
              ),
            );
          },
          child: Text("Save and open recipe"),
        )
      ],
    );
  }
}
