import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:dishdrop_app_projekt/core/utils/check_amount_and_convert.dart';
import 'package:dishdrop_app_projekt/core/utils/show_custom_alert_banner.dart';
import 'package:dishdrop_app_projekt/data/models/list_item.dart';
import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/recipe_controller.dart';
import 'package:dishdrop_app_projekt/data/shopping_list_controller.dart';
import 'package:dishdrop_app_projekt/ui/screens/recipe_details_screen.dart';

import 'package:dishdrop_app_projekt/ui/widgets/new_recipe_screen_widgets/category_dropdown_menu.dart';
import 'package:dishdrop_app_projekt/ui/widgets/new_recipe_screen_widgets/cooking_time_text_form_field.dart';
import 'package:dishdrop_app_projekt/ui/widgets/new_recipe_screen_widgets/description_text_form_field.dart';
import 'package:dishdrop_app_projekt/ui/widgets/new_recipe_screen_widgets/difficulty_dropdown_menu.dart';
import 'package:dishdrop_app_projekt/ui/widgets/new_recipe_screen_widgets/directions_list_view.dart';
import 'package:dishdrop_app_projekt/ui/widgets/new_recipe_screen_widgets/image_picker_field.dart';
import 'package:dishdrop_app_projekt/ui/widgets/new_recipe_screen_widgets/image_url_text_form_field.dart';
import 'package:dishdrop_app_projekt/ui/widgets/new_recipe_screen_widgets/notes_text_form_field.dart';
import 'package:dishdrop_app_projekt/ui/widgets/new_recipe_screen_widgets/prep_time_text_form_field.dart';
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
  final Map<String, TextEditingController> _allTextFormCtrl = {
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
                TitleTextFormField(titleCtrl: _allTextFormCtrl["titleCtrl"]!),
                CategoryDropdownMenu(
                    categoryCtrl: _allTextFormCtrl["categoryCtrl"]!),
                SizedBox(height: 30),
                ImagePickerField(),
                SizedBox(height: 30),
                ImageUrlTextFormField(
                    imgUrlCtrl: _allTextFormCtrl["imgUrlCtrl"]!),
                DifficultyDropdownMenu(
                    difficultyCtrl: _allTextFormCtrl["difficultyCtrl"]!),
                TagsTextFormField(tagsCtrl: _allTextFormCtrl["tagsCtrl"]!),
                DescriptionTextFormField(
                    descCtrl: _allTextFormCtrl["descCtrl"]!),
                Row(
                  spacing: 10,
                  children: [
                    Expanded(
                      child: PrepTimeTextFormField(
                          prepTimeCtrl: _allTextFormCtrl["prepTimeCtrl"]!),
                    ),
                    Expanded(
                      child: CookingTimeTextFormField(
                          cookingTimeCtrl:
                              _allTextFormCtrl["cookingTimeCtrl"]!),
                    ),
                  ],
                ),
                NotesTextFormField(notesCtrl: _allTextFormCtrl["notesCtrl"]!),
                SizedBox(height: 30),
                Text("Directions",
                    style: Theme.of(context).textTheme.headlineMedium),
                DirectionsListView(complexInputValues: complexInputValues),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _allTextFormCtrl["directionDescCtrl"],
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Add cooking directions"),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          final directionDescription =
                              _allTextFormCtrl["directionDescCtrl"]!.text;
                          setState(() {
                            if (_allTextFormCtrl["directionDescCtrl"]!.text !=
                                "") {
                              complexInputValues["directions"]
                                  .add(directionDescription);
                              _allTextFormCtrl["directionDescCtrl"]!.clear();
                            }
                          });
                        },
                        icon: Icon(
                          Icons.add_box_outlined,
                          size: 50,
                        ))
                  ],
                ),
                SizedBox(height: 30),
                Text("Ingredients",
                    style: Theme.of(context).textTheme.headlineMedium),
                Column(
                  children: List.generate(
                      complexInputValues["ingredients"].length, (index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: index.isEven
                              ? AppColors.lightGrey
                              : Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          spacing: 10,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${checkAmountAndConvert(complexInputValues["ingredients"][index].amount)} ${complexInputValues["ingredients"][index].unit?.toString() ?? ''}",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            // Text(
                            //   "${_userInputValues["ingredients"][index].amount?.toString() ?? ''} ${_userInputValues["ingredients"][index].unit?.toString() ?? ''}",
                            //   style: Theme.of(context).textTheme.bodyLarge,
                            // ),

                            Expanded(
                              child: Text(
                                complexInputValues["ingredients"][index]
                                    .description,
                                style: Theme.of(context).textTheme.bodyLarge,
                                textAlign: TextAlign.right,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 10,
                        children: [
                          TextFormField(
                            controller: _allTextFormCtrl["ingredientDescCtrl"],
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Ingredient description"),
                          ),
                          Row(
                            spacing: 10,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller:
                                      _allTextFormCtrl["ingredientAmountCtrl"],
                                  decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: AppColors.lightGrey,
                                    border: OutlineInputBorder(),
                                    hintText: "Amount",
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller:
                                      _allTextFormCtrl["ingredientUnitCtrl"],
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: "Unit"),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "You can enter fractional amounts like 1½ as 1.5",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(fontStyle: FontStyle.italic),
                          )
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          complexInputValues["ingredients"].add(
                            ListItem(
                              description:
                                  _allTextFormCtrl["ingredientDescCtrl"]!.text,
                              amount: double.tryParse(
                                  _allTextFormCtrl["ingredientAmountCtrl"]!
                                      .text),
                              unit:
                                  _allTextFormCtrl["ingredientUnitCtrl"]!.text,
                            ),
                          );
                          _allTextFormCtrl["ingredientAmountCtrl"]!.clear();
                          _allTextFormCtrl["ingredientUnitCtrl"]!.clear();
                          _allTextFormCtrl["ingredientDescCtrl"]!.clear();
                        });
                      },
                      icon: Icon(
                        Icons.add_box_outlined,
                        size: 50,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 5),
                TextButton(
                  style: TextButton.styleFrom(foregroundColor: Colors.red),
                  onPressed: () => resetAllCtrl(_allTextFormCtrl),
                  child: Text("Reset all fields"),
                ),
                SizedBox(height: 30),
                RecipeFormFooterButtonSection(
                    complexInputValues: complexInputValues,
                    widget: widget,
                    allTextFormCtrl: _allTextFormCtrl),
                SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RecipeFormFooterButtonSection extends StatelessWidget {
  const RecipeFormFooterButtonSection({
    super.key,
    required this.complexInputValues,
    required this.widget,
    required this.allTextFormCtrl,
  });

  final Map<String, dynamic> complexInputValues;

  final NewRecipeScreen widget;
  final Map<String, TextEditingController> allTextFormCtrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        FilledButton(
          onPressed: () {
            Recipe newRecipe =
                getCtrlInputValues(allTextFormCtrl, complexInputValues);
            widget.recipeController.addRecipe(newRecipe);
            showCustomAlertBanner(
                context, Colors.green, "Recipe added to cookbook!");
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
