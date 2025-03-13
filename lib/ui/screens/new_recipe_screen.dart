import 'package:dishdrop_app_projekt/data/models/list_item.dart';
import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/recipe_controller.dart';
import 'package:dishdrop_app_projekt/data/shopping_list_controller.dart';

import 'package:dishdrop_app_projekt/ui/widgets/new_recipe_screen_widgets/category_dropdown_menu.dart';
import 'package:dishdrop_app_projekt/ui/widgets/new_recipe_screen_widgets/cooking_time_text_form_field.dart';
import 'package:dishdrop_app_projekt/ui/widgets/new_recipe_screen_widgets/description_text_form_field.dart';
import 'package:dishdrop_app_projekt/ui/widgets/new_recipe_screen_widgets/difficulty_dropdown_menu.dart';
import 'package:dishdrop_app_projekt/ui/widgets/new_recipe_screen_widgets/cooking_directions_list_view.dart';
import 'package:dishdrop_app_projekt/ui/widgets/new_recipe_screen_widgets/image_picker_field.dart';

import 'package:dishdrop_app_projekt/ui/widgets/new_recipe_screen_widgets/notes_text_form_field.dart';
import 'package:dishdrop_app_projekt/ui/widgets/new_recipe_screen_widgets/prep_time_text_form_field.dart';
import 'package:dishdrop_app_projekt/ui/widgets/new_recipe_screen_widgets/cooking_direction_input_section.dart';
import 'package:dishdrop_app_projekt/ui/widgets/new_recipe_screen_widgets/recipe_form_footer_button_section.dart';
import 'package:dishdrop_app_projekt/ui/widgets/new_recipe_screen_widgets/ingredient_input_section.dart';
import 'package:dishdrop_app_projekt/ui/widgets/new_recipe_screen_widgets/recipe_form_ingredient_list_view.dart';
import 'package:dishdrop_app_projekt/ui/widgets/new_recipe_screen_widgets/tags_list_view.dart';
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
  final formKey = GlobalKey<FormState>();
  late List<Recipe> allRecipes;
  bool showImgPickerError = false;
  bool showCategoryError = false;
  bool showDifficultyError = false;
  String? imagePath;

  final Map<String, TextEditingController> allTextControllers = {
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

  Map<String, dynamic> complexInputValues = {
    "images": {
      "titleImg": "",
      "cookingDirectionImg": [],
    },
    "tags": <String>[],
    "ingredients": <ListItem>[],
    "directions": <String>[]
  };

  @override
  void initState() {
    super.initState();
    allRecipes = widget.recipeController.getAllRecipes();
  }

  @override
  void dispose() {
    super.dispose();
    for (var ctrlKey in allTextControllers.keys) {
      allTextControllers[ctrlKey]?.dispose();
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
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                TitleTextFormField(
                  titleCtrl: allTextControllers["titleCtrl"]!,
                  allRecipes: allRecipes,
                ),
                CategoryDropdownMenu(
                  categoryCtrl: allTextControllers["categoryCtrl"]!,
                  showErrorFunc: updateCategoryMenuError,
                  getErrorStateFunc: getCategoryErrorState,
                ),
                SizedBox(height: 30),
                ImagePickerField(
                  updateImagesFunc: updateImage,
                  emptyImgPickerFunc: emptyImagePicker,
                  showError: showImgPickerError,
                  imagePath: imagePath,
                ),
                SizedBox(height: 20),
                DifficultyDropdownMenu(
                  difficultyCtrl: allTextControllers["difficultyCtrl"]!,
                  showError: showDifficultyError,
                ),
                TagsInputSection(
                  complexInputValues: complexInputValues,
                  tagsCtrl: allTextControllers["tagsCtrl"]!,
                  updateTagsList: addToTagsList,
                ),
                TagsListView(
                  complexInputValues: complexInputValues,
                  removeFromTagsList: removeFromTagsList,
                ),
                SizedBox(height: 20),
                DescriptionTextFormField(
                    descCtrl: allTextControllers["descCtrl"]!),
                Row(
                  spacing: 10,
                  children: [
                    Expanded(
                      child: PrepTimeTextFormField(
                          prepTimeCtrl: allTextControllers["prepTimeCtrl"]!),
                    ),
                    Expanded(
                      child: CookingTimeTextFormField(
                          cookingTimeCtrl:
                              allTextControllers["cookingTimeCtrl"]!),
                    ),
                  ],
                ),
                NotesTextFormField(notesCtrl: allTextControllers["notesCtrl"]!),
                SizedBox(height: 30),
                Text("Directions",
                    style: Theme.of(context).textTheme.headlineMedium),
                CookingDirectionsListView(
                    complexInputValues: complexInputValues),
                CookingDirectionInputSection(
                  complexInputValues: complexInputValues,
                  cookingDirectionCtrl:
                      allTextControllers["directionDescCtrl"]!,
                  updateDirectionList: updateDirectionList,
                ),
                SizedBox(height: 30),
                Text("Ingredients",
                    style: Theme.of(context).textTheme.headlineMedium),
                RecipeFormIngredientListView(
                    complexInputValues: complexInputValues),
                SizedBox(height: 20),
                IngredientInputSection(
                  allTextFormCtrl: allTextControllers,
                  complexInputValues: complexInputValues,
                  updateIngredientList: updateIngredientList,
                ),
                SizedBox(height: 5),
                TextButton(
                  style: TextButton.styleFrom(foregroundColor: Colors.red),
                  onPressed: () => resetAllCtrl(allTextControllers, formKey),
                  child: Text("Reset all fields"),
                ),
                SizedBox(height: 30),
                RecipeFormFooterButtonSection(
                  complexInputValues: complexInputValues,
                  widget: widget,
                  allTextFormCtrl: allTextControllers,
                  formKey: formKey,
                  inputValuesValidFunc: checkNoneTextfieldValues,
                  resetAllCtrl: resetAllCtrl,
                ),
                SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updateCategoryMenuError(bool showError) {
    showCategoryError = showError;
  }

  bool getCategoryErrorState() {
    return showCategoryError;
  }

  void updateIngredientList() {
    setState(() {
      complexInputValues["ingredients"].add(
        ListItem(
          description: allTextControllers["ingredientDescCtrl"]!.text,
          amount:
              double.tryParse(allTextControllers["ingredientAmountCtrl"]!.text),
          unit: allTextControllers["ingredientUnitCtrl"]!.text,
        ),
      );
      allTextControllers["ingredientAmountCtrl"]!.clear();
      allTextControllers["ingredientUnitCtrl"]!.clear();
      allTextControllers["ingredientDescCtrl"]!.clear();
    });
  }

  void updateDirectionList() {
    final directionDescription = allTextControllers["directionDescCtrl"]!.text;
    setState(
      () {
        if (allTextControllers["directionDescCtrl"]!.text != "") {
          complexInputValues["directions"].add(directionDescription);
          allTextControllers["directionDescCtrl"]!.clear();
        }
      },
    );
  }

  void addToTagsList() {
    final tagsTitle = allTextControllers["tagsCtrl"]!.text;
    setState(() {
      if (allTextControllers["tagsCtrl"]!.text != "") {
        complexInputValues["tags"].add(tagsTitle);
        allTextControllers["tagsCtrl"]!.clear();
      }
    });
  }

  void removeFromTagsList(tagTitle) {
    setState(() {
      complexInputValues["tags"].remove(tagTitle);
    });
  }

  void updateImage(String imagesKey, String imagePathFromPicker) {
    if (imagesKey == "titleImg") {
      complexInputValues["images"][imagesKey] = imagePathFromPicker;
      imagePath = imagePathFromPicker;
    }
  }

  void emptyImagePicker() {
    setState(() {
      imagePath = null;
      complexInputValues["images"]["titleImg"] = "";
      updateImage("titleImg", "");
      showImgPickerError = false;
    });
  }

  void resetAllCtrl(
      Map<String, TextEditingController> allTextFormCtrl, formKey) {
    for (var key in allTextFormCtrl.keys) {
      allTextFormCtrl[key]!.clear();
    }
    showImgPickerError = false;
    showCategoryError = false;
    showDifficultyError = false;

    if (formKey != null) {
      formKey.currentState?.reset();
    }

    setState(() {
      complexInputValues = {
        "images": {
          "titleImg": "",
          "cookingDirectionImg": [],
        },
        "tags": <String>[],
        "ingredients": <ListItem>[],
        "directions": <String>[]
      };
    });
    emptyImagePicker();
  }

  bool checkNoneTextfieldValues(
      Map<String, TextEditingController> allTextFormCtrl, complexInputValues) {
    allTextFormCtrl["categoryCtrl"]?.text ?? "";

    String? categoryText = allTextFormCtrl["categoryCtrl"]?.text;
    if (categoryText == null || categoryText.isEmpty) {
      setState(() {
        showCategoryError = true;
      });
    } else {
      setState(() {
        showCategoryError = false;
      });
    }

    String? difficultyText = allTextFormCtrl["difficultyCtrl"]?.text;
    if (difficultyText == null || difficultyText.isEmpty) {
      setState(() {
        showDifficultyError = true;
      });
    } else {
      setState(() {
        showDifficultyError = false;
      });
    }

    String titleImg = complexInputValues["images"]["titleImg"];

    if (titleImg.isEmpty) {
      setState(() {
        showImgPickerError = true;
      });
    } else {
      setState(() {
        showImgPickerError = false;
      });
    }

    if (showCategoryError || showDifficultyError || showImgPickerError) {
      return false;
    } else {
      return true;
    }
  }
}
