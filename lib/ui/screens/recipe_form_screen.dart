import 'package:dishdrop_app_projekt/data/provider/recipe_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:dishdrop_app_projekt/data/provider/recipe_form_notifier.dart';
import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_form_screen_widgets/category_dropdown_menu.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_form_screen_widgets/cooking_time_text_form_field.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_form_screen_widgets/description_text_form_field.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_form_screen_widgets/difficulty_dropdown_menu.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_form_screen_widgets/cooking_directions_list_view.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_form_screen_widgets/image_picker_field.dart';

import 'package:dishdrop_app_projekt/ui/widgets/recipe_form_screen_widgets/notes_text_form_field.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_form_screen_widgets/prep_time_text_form_field.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_form_screen_widgets/cooking_direction_input_section.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_form_screen_widgets/footer_button_section.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_form_screen_widgets/ingredient_input_section.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_form_screen_widgets/ingredient_list_view.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_form_screen_widgets/tags_list_view.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_form_screen_widgets/tags_text_form_field.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_form_screen_widgets/title_text_form_field.dart';

class RecipeFormScreen extends StatefulWidget {
  const RecipeFormScreen({
    super.key,
  });

  @override
  State<RecipeFormScreen> createState() => _RecipeFormScreenState();
}

class _RecipeFormScreenState extends State<RecipeFormScreen> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    final recipeFormNotifier = context.watch<RecipeFormNotifier>();
    final recipeNotifier = context.watch<RecipeNotifier>();
    Recipe? recipe = recipeFormNotifier.recipe;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(recipeFormNotifier.isEditingRecipe ? "Edit recipe" : "New recipe",
              style: Theme.of(context).textTheme.headlineLarge),
          actions: [
            if (recipeFormNotifier.draftAvailable)
              TextButton(
                onPressed: () {
                  recipeFormNotifier.resetAllCtrl();
                },
                child: Text(
                  "Delete Draft",
                  style: TextStyle(color: Colors.red),
                ),
              )
          ],
        ),
        body: Form(
          key: recipeFormNotifier.formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  TitleTextFormField(),
                  CategoryDropdownMenu(),
                  SizedBox(height: 30),
                  ImagePickerField(),
                  SizedBox(height: 20),
                  DifficultyDropdownMenu(),
                  TagsInputSection(),
                  TagsListView(),
                  SizedBox(height: 20),
                  DescriptionTextFormField(),
                  Row(
                    spacing: 10,
                    children: [
                      Expanded(child: PrepTimeTextFormField()),
                      Expanded(child: CookingTimeTextFormField()),
                    ],
                  ),
                  NotesTextFormField(),
                  SizedBox(height: 30),
                  Text("Cooking Directions", style: Theme.of(context).textTheme.headlineMedium),
                  CookingDirectionsListView(),
                  CookingDirectionInputSection(),
                  SizedBox(height: 30),
                  Text("Ingredients", style: Theme.of(context).textTheme.headlineMedium),
                  IngredientListView(),
                  if (recipeFormNotifier.complexInputValues["ingredients"].isNotEmpty) SizedBox(height: 20),
                  IngredientInputSection(),
                  SizedBox(height: 30),
                  if (recipeFormNotifier.isEditingRecipe)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            style: Theme.of(context).textTheme.bodyLarge,
                            'You have cooked this recipe ${recipeFormNotifier.recipe?.timesCooked} ${recipeFormNotifier.recipe?.timesCooked == 1 ? 'time' : 'times.'}'),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: recipe?.timesCooked == 0
                              ? null
                              : () {
                                  recipe?.timesCooked = 0;
                                  recipeNotifier.updateRecipe(recipe!.id, recipe);
                                },
                          child: Text(
                            "Reset counter",
                            style:
                                recipe?.timesCooked == 0 ? TextStyle(color: Colors.grey) : TextStyle(color: Colors.red),
                            // style: TextStyle(color: Colors.red),
                          ),
                        )
                      ],
                    ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    style: TextButton.styleFrom(foregroundColor: Colors.red),
                    onPressed: () => recipeFormNotifier.resetAllCtrl(),
                    child: Text("Reset all fields"),
                  ),
                  Text(
                    "Warning: This cannot be undone!",
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(fontStyle: FontStyle.italic),
                  ),
                  SizedBox(height: 30),
                  FooterButtonSection(),
                  SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
