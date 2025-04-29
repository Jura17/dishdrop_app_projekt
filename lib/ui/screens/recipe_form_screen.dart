import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/provider/recipe_form_provider.dart';

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
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipeFormWrapper extends StatelessWidget {
  const RecipeFormWrapper({super.key, this.recipe});

  final Recipe? recipe;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RecipeFormProvider>(
      create: (_) => RecipeFormProvider(recipe: recipe),
      child: RecipeFormScreen(),
    );
  }
}

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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final recipeFormProvider = Provider.of<RecipeFormProvider>(context, listen: false);
      recipeFormProvider.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final recipeFormProvider = Provider.of<RecipeFormProvider>(context, listen: false);
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
                  recipeFormProvider.resetAllCtrl(recipeFormProvider.allTextControllers, recipeFormProvider.formKey);
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
                  ImagePickerField(
                    updateImagesFunc: recipeFormProvider.updateImage,
                    emptyImgPickerFunc: recipeFormProvider.emptyImagePicker,
                    imagePath: recipeFormProvider.imagePath,
                  ),
                  SizedBox(height: 20),
                  DifficultyDropdownMenu(
                    difficultyCtrl: recipeFormProvider.allTextControllers["difficultyCtrl"]!,
                    showErrorFunc: recipeFormProvider.updateDifficultyMenuError,
                    getErrorStateFunc: recipeFormProvider.getDifficultyErrorState,
                  ),
                  TagsInputSection(
                    complexInputValues: recipeFormProvider.complexInputValues,
                    tagsCtrl: recipeFormProvider.allTextControllers["tagsCtrl"]!,
                    updateTagsList: recipeFormProvider.addToTagsList,
                  ),
                  TagsListView(
                    complexInputValues: recipeFormProvider.complexInputValues,
                    removeFromTagsList: recipeFormProvider.removeFromTagsList,
                  ),
                  SizedBox(height: 20),
                  DescriptionTextFormField(descCtrl: recipeFormProvider.allTextControllers["descCtrl"]!),
                  Row(
                    spacing: 10,
                    children: [
                      Expanded(
                        child:
                            PrepTimeTextFormField(prepTimeCtrl: recipeFormProvider.allTextControllers["prepTimeCtrl"]!),
                      ),
                      Expanded(
                        child: CookingTimeTextFormField(
                            cookingTimeCtrl: recipeFormProvider.allTextControllers["cookingTimeCtrl"]!),
                      ),
                    ],
                  ),
                  NotesTextFormField(notesCtrl: recipeFormProvider.allTextControllers["notesCtrl"]!),
                  SizedBox(height: 30),
                  Text("Cooking Directions", style: Theme.of(context).textTheme.headlineMedium),
                  CookingDirectionsListView(
                    complexInputValues: recipeFormProvider.complexInputValues,
                    removeFromCookingDirectionsListFunc: recipeFormProvider.removeCookingDirection,
                  ),
                  CookingDirectionInputSection(
                    complexInputValues: recipeFormProvider.complexInputValues,
                    cookingDirectionCtrl: recipeFormProvider.allTextControllers["directionDescCtrl"]!,
                    addCookingDirectionFunc: recipeFormProvider.addCookingDirectionToList,
                  ),
                  SizedBox(height: 30),
                  Text("Ingredients", style: Theme.of(context).textTheme.headlineMedium),
                  IngredientListView(
                    complexInputValues: recipeFormProvider.complexInputValues,
                    removeFromListFunc: recipeFormProvider.removeFromIngredientList,
                  ),
                  if (recipeFormProvider.complexInputValues["ingredients"].isNotEmpty) SizedBox(height: 20),
                  IngredientInputSection(
                    allTextFormCtrl: recipeFormProvider.allTextControllers,
                    complexInputValues: recipeFormProvider.complexInputValues,
                    addIngredientFunc: recipeFormProvider.addIngredientToList,
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    style: TextButton.styleFrom(foregroundColor: Colors.red),
                    onPressed: () => recipeFormProvider.resetAllCtrl(
                        recipeFormProvider.allTextControllers, recipeFormProvider.formKey),
                    child: Text("Reset all fields"),
                  ),
                  SizedBox(height: 10),
                  FooterButtonSection(
                    complexInputValues: recipeFormProvider.complexInputValues,
                    widget: widget,
                    allTextFormCtrl: recipeFormProvider.allTextControllers,
                    formKey: recipeFormProvider.formKey,
                    checkNoneTextFieldValuesFunc: recipeFormProvider.checkNoneTextfieldValues,
                    resetAllCtrl: recipeFormProvider.resetAllCtrl,
                    isEditingRecipe: recipeFormProvider.isEditingRecipe,
                  ),
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
