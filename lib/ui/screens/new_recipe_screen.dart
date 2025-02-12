import 'package:dishdrop_app_projekt/data/models/list_item.dart';
import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/recipe_controller.dart';
import 'package:dishdrop_app_projekt/data/shopping_list_controller.dart';

import 'package:dishdrop_app_projekt/ui/widgets/new_recipe_screen_widgets/category_dropdown_menu.dart';
import 'package:dishdrop_app_projekt/ui/widgets/new_recipe_screen_widgets/cooking_time_text_form_field.dart';
import 'package:dishdrop_app_projekt/ui/widgets/new_recipe_screen_widgets/description_text_form_field.dart';
import 'package:dishdrop_app_projekt/ui/widgets/new_recipe_screen_widgets/difficulty_dropdown_menu.dart';
import 'package:dishdrop_app_projekt/ui/widgets/new_recipe_screen_widgets/directions_list_view.dart';
import 'package:dishdrop_app_projekt/ui/widgets/new_recipe_screen_widgets/image_picker_field.dart';
import 'package:dishdrop_app_projekt/ui/widgets/new_recipe_screen_widgets/image_url_text_form_field.dart';
import 'package:dishdrop_app_projekt/ui/widgets/new_recipe_screen_widgets/notes_text_form_field.dart';
import 'package:dishdrop_app_projekt/ui/widgets/new_recipe_screen_widgets/prep_time_text_form_field.dart';
import 'package:dishdrop_app_projekt/ui/widgets/new_recipe_screen_widgets/recipe_form_direction_input_section.dart';
import 'package:dishdrop_app_projekt/ui/widgets/new_recipe_screen_widgets/recipe_form_footer_button_section.dart';
import 'package:dishdrop_app_projekt/ui/widgets/new_recipe_screen_widgets/recipe_form_ingredient_input_section.dart';
import 'package:dishdrop_app_projekt/ui/widgets/new_recipe_screen_widgets/recipe_form_ingredient_list_view.dart';
import 'package:dishdrop_app_projekt/ui/widgets/new_recipe_screen_widgets/tags_text_form_field.dart';
import 'package:dishdrop_app_projekt/ui/widgets/new_recipe_screen_widgets/title_text_form_field.dart';
import 'package:flutter/material.dart';

class NewRecipeScreen extends StatefulWidget {
  const NewRecipeScreen({
    super.key,
    required this.recipeController,
    required this.shoppingListController,
  });
  final RecipeController recipeController;
  final ShoppingListController shoppingListController;

  @override
  State<NewRecipeScreen> createState() => _NewRecipeScreenState();
}

class _NewRecipeScreenState extends State<NewRecipeScreen> {
  final Map<String, TextEditingController> allTextFormCtrl = {
    "titleCtrl": TextEditingController(),
    "categoryCtrl": TextEditingController(),
    "imgUrlCtrl": TextEditingController(),
    "difficultyCtrl": TextEditingController(),
    "tagsCtrl": TextEditingController(),
    "descCtrl": TextEditingController(),
    "prepTimeCtrl": TextEditingController(),
    "cookingTimeCtrl": TextEditingController(),
    "notesCtrl": TextEditingController(),
    "ingredientAmountCtrl": TextEditingController(),
    "ingredientUnitCtrl": TextEditingController(),
    "ingredientDescCtrl": TextEditingController(),
    "directionDescCtrl": TextEditingController(),
  };

  final Map<String, dynamic> complexInputValues = {
    "images": {
      "titleImg": "",
      "cookingDirectionImg": [],
    },
    "tags": <String>[],
    "ingredients": <ListItem>[],
    "directions": <String>[]
  };

  @override
  void dispose() {
    super.dispose();
    for (var ctrlKey in allTextFormCtrl.keys) {
      allTextFormCtrl[ctrlKey]?.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New recipe",
            style: Theme.of(context).textTheme.headlineLarge),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                TitleTextFormField(titleCtrl: allTextFormCtrl["titleCtrl"]!),
                CategoryDropdownMenu(
                    categoryCtrl: allTextFormCtrl["categoryCtrl"]!),
                SizedBox(height: 30),
                ImagePickerField(),
                SizedBox(height: 30),
                ImageUrlTextFormField(
                    imgUrlCtrl: allTextFormCtrl["imgUrlCtrl"]!),
                DifficultyDropdownMenu(
                    difficultyCtrl: allTextFormCtrl["difficultyCtrl"]!),
                TagsTextFormField(tagsCtrl: allTextFormCtrl["tagsCtrl"]!),
                DescriptionTextFormField(
                    descCtrl: allTextFormCtrl["descCtrl"]!),
                Row(
                  spacing: 10,
                  children: [
                    Expanded(
                      child: PrepTimeTextFormField(
                          prepTimeCtrl: allTextFormCtrl["prepTimeCtrl"]!),
                    ),
                    Expanded(
                      child: CookingTimeTextFormField(
                          cookingTimeCtrl: allTextFormCtrl["cookingTimeCtrl"]!),
                    ),
                  ],
                ),
                NotesTextFormField(notesCtrl: allTextFormCtrl["notesCtrl"]!),
                SizedBox(height: 30),
                Text("Directions",
                    style: Theme.of(context).textTheme.headlineMedium),
                DirectionsListView(complexInputValues: complexInputValues),
                RecipeFormDirectionInputSection(
                  complexInputValues: complexInputValues,
                  allTextFormCtrl: allTextFormCtrl,
                  updateDirectionList: updateDirectionList,
                ),
                SizedBox(height: 30),
                Text("Ingredients",
                    style: Theme.of(context).textTheme.headlineMedium),
                RecipeFormIngredientListView(
                    complexInputValues: complexInputValues),
                SizedBox(height: 20),
                RecipeFormIngredientInputSection(
                  allTextFormCtrl: allTextFormCtrl,
                  complexInputValues: complexInputValues,
                  updateIngredientList: updateIngredientList,
                ),
                SizedBox(height: 5),
                TextButton(
                  style: TextButton.styleFrom(foregroundColor: Colors.red),
                  onPressed: () => resetAllCtrl(allTextFormCtrl),
                  child: Text("Reset all fields"),
                ),
                SizedBox(height: 30),
                RecipeFormFooterButtonSection(
                    complexInputValues: complexInputValues,
                    widget: widget,
                    allTextFormCtrl: allTextFormCtrl),
                SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updateIngredientList() {
    setState(() {
      complexInputValues["ingredients"].add(
        ListItem(
          description: allTextFormCtrl["ingredientDescCtrl"]!.text,
          amount:
              double.tryParse(allTextFormCtrl["ingredientAmountCtrl"]!.text),
          unit: allTextFormCtrl["ingredientUnitCtrl"]!.text,
        ),
      );
      allTextFormCtrl["ingredientAmountCtrl"]!.clear();
      allTextFormCtrl["ingredientUnitCtrl"]!.clear();
      allTextFormCtrl["ingredientDescCtrl"]!.clear();
    });
  }

  void updateDirectionList() {
    final directionDescription = allTextFormCtrl["directionDescCtrl"]!.text;
    setState(() {
      if (allTextFormCtrl["directionDescCtrl"]!.text != "") {
        complexInputValues["directions"].add(directionDescription);
        allTextFormCtrl["directionDescCtrl"]!.clear();
      }
    });
  }
}

Recipe getCtrlInputValues(
    Map<String, TextEditingController> allTextFormCtrl, complexInputValues) {
  complexInputValues["images"]["titleImg"] =
      allTextFormCtrl["imgUrlCtrl"]?.text ?? "";

  final String title = allTextFormCtrl["titleCtrl"]?.text ?? "";
  final String category = allTextFormCtrl["categoryCtrl"]?.text ?? "";
  final String description = allTextFormCtrl["descCtrl"]?.text ?? "";
  final String notes = allTextFormCtrl["notesCtrl"]?.text ?? "";
  final String difficulty = allTextFormCtrl["difficultyCtrl"]?.text ?? "";
  final List<String> tags = complexInputValues["tags"];
  final Map<String, dynamic> imagesInput = complexInputValues["images"];
  final int prepTime = int.tryParse(allTextFormCtrl["prepTimeCtrl"]!.text) ?? 0;
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

void resetAllCtrl(Map<String, TextEditingController> allTextFormCtrl) {
  for (var key in allTextFormCtrl.keys) {
    allTextFormCtrl[key]!.clear();
  }
}
