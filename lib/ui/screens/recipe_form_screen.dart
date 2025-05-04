import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:dishdrop_app_projekt/data/provider/recipe_form_provider.dart';
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
    this.recipe,
  });

  final Recipe? recipe;

  @override
  State<RecipeFormScreen> createState() => _RecipeFormScreenState();
}

class _RecipeFormScreenState extends State<RecipeFormScreen> with WidgetsBindingObserver {
  late RecipeFormProvider _recipeFormProvider;
  bool _didInit = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_didInit) {
      _recipeFormProvider = context.read<RecipeFormProvider>();
      _recipeFormProvider.init(widget.recipe);
      _didInit = true;

      if (!_recipeFormProvider.isEditingRecipe && !_recipeFormProvider.draftAvailable) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _recipeFormProvider.resetAllCtrl();
        });
      }
    }
  }

  @override
  void dispose() {
    _recipeFormProvider.cacheAllOnExit();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final recipeFormProvider = context.watch<RecipeFormProvider>();
    recipeFormProvider.draftAvailable ? print("draft available") : print("No draft");
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(recipeFormProvider.isEditingRecipe ? "Edit recipe" : "New recipe",
              style: Theme.of(context).textTheme.headlineLarge),
          actions: [
            if (recipeFormProvider.draftAvailable)
              TextButton(
                onPressed: () {
                  recipeFormProvider.resetAllCtrl();
                },
                child: Text(
                  "Delete Draft",
                  style: TextStyle(color: Colors.red),
                ),
              )
          ],
        ),
        body: Form(
          key: recipeFormProvider.formKey,
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
                  if (recipeFormProvider.complexInputValues["ingredients"].isNotEmpty) SizedBox(height: 20),
                  IngredientInputSection(),
                  SizedBox(height: 30),
                  ElevatedButton(
                    style: TextButton.styleFrom(foregroundColor: Colors.red),
                    onPressed: () => recipeFormProvider.resetAllCtrl(),
                    child: Text("Reset all fields"),
                  ),
                  SizedBox(height: 10),
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
