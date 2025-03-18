import 'package:dishdrop_app_projekt/data/models/list_item.dart';
import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/recipe_controller.dart';
import 'package:dishdrop_app_projekt/data/repositories/shared_preferences_repository.dart';
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
import 'dart:convert';

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

class _NewRecipeScreenState extends State<NewRecipeScreen> with WidgetsBindingObserver {
  final formKey = GlobalKey<FormState>();
  SharedPreferencesRepository sharedPreferencesRepository = SharedPreferencesRepository();
  late List<Recipe> allRecipes;
  bool _showImgPickerError = false;
  bool _showCategoryError = false;
  bool _showDifficultyError = false;
  bool _draftAvailable = false;
  String? imagePath;
  Map<String, dynamic> allInputFields = {
    "images": {
      "titleImg": "",
      "cookingDirectionImg": [],
    },
  };

  final Map<String, TextEditingController> allTextControllers = {
    "titleCtrl": TextEditingController(),
    "categoryCtrl": TextEditingController(),
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

  Map<String, dynamic> _complexInputValues = {
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
    WidgetsBinding.instance.addObserver(this);
    loadCachedInput();
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   super.didChangeAppLifecycleState(state);

  //   switch (state) {
  //     case AppLifecycleState.resumed:
  //       // Load input string list from shared prefs
  //       break;
  //     case AppLifecycleState.paused:
  //     case AppLifecycleState.inactive:
  //     case AppLifecycleState.detached:
  //       saveAllInputToList();
  //       break;
  //     default:
  //       break;
  //   }
  // }

  void saveAllInputToList() {
    for (var key in allTextControllers.keys) {
      allInputFields[key] = allTextControllers[key]!.text;
    }

    allInputFields["images"]["titleImg"] = _complexInputValues["images"]["titleImg"];
    allInputFields["images"]["cookingDirectionImg"] = _complexInputValues["images"]["cookingDirectionImg"];
    allInputFields["tags"] = _complexInputValues["tags"];

    List<String> ingredientStringList = [];
    for (ListItem ingredient in _complexInputValues["ingredients"]) {
      final ingredientMap = ingredient.toJson();
      ingredientStringList.add(jsonEncode(ingredientMap));
    }
    final String ingredientsEncoded = jsonEncode(ingredientStringList);

    allInputFields["ingredients"] = ingredientsEncoded;
    allInputFields["directions"] = _complexInputValues["directions"];

    final jsonString = jsonEncode(allInputFields);
    sharedPreferencesRepository.overrideCachedInput(jsonString);
  }

  // check if json response contains actual values or nothing but empty strings, lists and maps or if an empty list is actually returned as a string: "[]"
  bool allValuesEmpty(dynamic value) {
    if (value is String) return value.trim().isEmpty || value == "[]";
    if (value is List) return value.isEmpty;
    if (value is Map) return value.isEmpty || value.values.every(allValuesEmpty);
    return false;
  }

  void loadCachedInput() async {
    final jsonString = await sharedPreferencesRepository.cachedInput;

    if (jsonString.isNotEmpty) {
      final cachedInput = jsonDecode(jsonString);
      bool jsonStringHasNoValues = allValuesEmpty(cachedInput);
      if (!jsonStringHasNoValues) {
        // decode all text input fields
        for (var key in allTextControllers.keys) {
          allTextControllers[key]!.text = cachedInput[key];
        }
        // decode title image
        if (cachedInput["images"]["titleImg"].isNotEmpty) {
          updateImage("titleImg", cachedInput["images"]["titleImg"]);
          _complexInputValues["images"]["titleImg"] = cachedInput["images"]["titleImg"];
        }

        // decode ingredients
        final List<dynamic> ingredientList = jsonDecode(cachedInput["ingredients"]);
        final List<ListItem> decodedIngredientList = [];
        for (var ingredientItem in ingredientList) {
          Map ingredientDecoded = jsonDecode(ingredientItem);
          ListItem newListItem = ListItem(
              description: ingredientDecoded["description"],
              amount: ingredientDecoded["amount"],
              unit: ingredientDecoded["unit"]);
          decodedIngredientList.add(newListItem);
        }
        _complexInputValues["ingredients"] = decodedIngredientList;

        // decode cooking directions
        if (cachedInput["directions"].isNotEmpty) {
          _complexInputValues["directions"] = cachedInput["directions"];
        }

        // decode tags
        if (cachedInput["tags"].isNotEmpty) {
          List<String> tagList = cachedInput["tags"].cast<String>();
          _complexInputValues["tags"] = tagList;
        }
        _draftAvailable = true;
        setState(() {});
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    saveAllInputToList();
    WidgetsBinding.instance.removeObserver(this);
    for (var ctrlKey in allTextControllers.keys) {
      allTextControllers[ctrlKey]?.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New recipe", style: Theme.of(context).textTheme.headlineLarge),
        actions: [
          if (_draftAvailable)
            TextButton(
                onPressed: () {
                  resetAllCtrl(allTextControllers, formKey);
                },
                child: Text(
                  "Delete Draft",
                  style: TextStyle(color: Colors.red),
                ))
        ],
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
                  showError: _showImgPickerError,
                  imagePath: imagePath,
                ),
                SizedBox(height: 20),
                DifficultyDropdownMenu(
                  difficultyCtrl: allTextControllers["difficultyCtrl"]!,
                  showError: _showDifficultyError,
                ),
                TagsInputSection(
                  complexInputValues: _complexInputValues,
                  tagsCtrl: allTextControllers["tagsCtrl"]!,
                  updateTagsList: addToTagsList,
                ),
                TagsListView(
                  complexInputValues: _complexInputValues,
                  removeFromTagsList: removeFromTagsList,
                ),
                SizedBox(height: 20),
                DescriptionTextFormField(descCtrl: allTextControllers["descCtrl"]!),
                Row(
                  spacing: 10,
                  children: [
                    Expanded(
                      child: PrepTimeTextFormField(prepTimeCtrl: allTextControllers["prepTimeCtrl"]!),
                    ),
                    Expanded(
                      child: CookingTimeTextFormField(cookingTimeCtrl: allTextControllers["cookingTimeCtrl"]!),
                    ),
                  ],
                ),
                NotesTextFormField(notesCtrl: allTextControllers["notesCtrl"]!),
                SizedBox(height: 30),
                Text("Cooking Directions", style: Theme.of(context).textTheme.headlineMedium),
                CookingDirectionsListView(complexInputValues: _complexInputValues),
                CookingDirectionInputSection(
                  complexInputValues: _complexInputValues,
                  cookingDirectionCtrl: allTextControllers["directionDescCtrl"]!,
                  updateDirectionList: updateDirectionList,
                ),
                SizedBox(height: 30),
                Text("Ingredients", style: Theme.of(context).textTheme.headlineMedium),
                RecipeFormIngredientListView(complexInputValues: _complexInputValues),
                if (_complexInputValues["ingredients"].isNotEmpty) SizedBox(height: 20),
                IngredientInputSection(
                  allTextFormCtrl: allTextControllers,
                  complexInputValues: _complexInputValues,
                  updateIngredientList: updateIngredientList,
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  style: TextButton.styleFrom(foregroundColor: Colors.red),
                  onPressed: () => resetAllCtrl(allTextControllers, formKey),
                  child: Text("Reset all fields"),
                ),
                SizedBox(height: 10),
                RecipeFormFooterButtonSection(
                  complexInputValues: _complexInputValues,
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
    _showCategoryError = showError;
  }

  bool getCategoryErrorState() {
    return _showCategoryError;
  }

  void updateIngredientList() {
    setState(() {
      _complexInputValues["ingredients"].add(
        ListItem(
          description: allTextControllers["ingredientDescCtrl"]!.text,
          amount: double.tryParse(allTextControllers["ingredientAmountCtrl"]!.text),
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
          _complexInputValues["directions"].add(directionDescription);
          allTextControllers["directionDescCtrl"]!.clear();
        }
      },
    );
  }

  void addToTagsList() {
    final tagsTitle = allTextControllers["tagsCtrl"]!.text;
    setState(() {
      if (allTextControllers["tagsCtrl"]!.text != "") {
        _complexInputValues["tags"].add(tagsTitle);
        allTextControllers["tagsCtrl"]!.clear();
      }
    });
  }

  void removeFromTagsList(tagTitle) {
    setState(() {
      _complexInputValues["tags"].remove(tagTitle);
    });
  }

  void updateImage(String imagesKey, String imagePathFromPicker) {
    if (imagesKey == "titleImg") {
      _complexInputValues["images"][imagesKey] = imagePathFromPicker;
      imagePath = imagePathFromPicker;
    }
  }

  void emptyImagePicker() {
    setState(() {
      imagePath = null;
      _complexInputValues["images"]["titleImg"] = "";
      updateImage("titleImg", "");
      _showImgPickerError = false;
    });
  }

  void resetAllCtrl(Map<String, TextEditingController> allTextFormCtrl, formKey) {
    if (formKey != null) {
      formKey.currentState?.reset();
    }
    for (var key in allTextFormCtrl.keys) {
      allTextFormCtrl[key]!.clear();
    }
    _showImgPickerError = false;
    _showCategoryError = false;
    _showDifficultyError = false;

    _complexInputValues = {
      "images": {
        "titleImg": "",
        "cookingDirectionImg": [],
      },
      "tags": <String>[],
      "ingredients": <ListItem>[],
      "directions": <String>[]
    };
    emptyImagePicker();
    sharedPreferencesRepository.deleteCachedInput();
    _draftAvailable = false;
    setState(() {});
  }

  bool checkNoneTextfieldValues(Map<String, TextEditingController> allTextFormCtrl, complexInputValues) {
    allTextFormCtrl["categoryCtrl"]?.text ?? "";

    String? categoryText = allTextFormCtrl["categoryCtrl"]?.text;
    if (categoryText == null || categoryText.isEmpty) {
      setState(() {
        _showCategoryError = true;
      });
    } else {
      setState(() {
        _showCategoryError = false;
      });
    }

    String? difficultyText = allTextFormCtrl["difficultyCtrl"]?.text;
    if (difficultyText == null || difficultyText.isEmpty) {
      setState(() {
        _showDifficultyError = true;
      });
    } else {
      setState(() {
        _showDifficultyError = false;
      });
    }

    String titleImg = complexInputValues["images"]["titleImg"];

    if (titleImg.isEmpty) {
      setState(() {
        _showImgPickerError = true;
      });
    } else {
      setState(() {
        _showImgPickerError = false;
      });
    }

    if (_showCategoryError || _showDifficultyError || _showImgPickerError) {
      return false;
    } else {
      return true;
    }
  }
}
