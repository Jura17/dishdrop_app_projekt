import 'dart:convert';

import 'package:dishdrop_app_projekt/data/models/cooking_direction.dart';
import 'package:dishdrop_app_projekt/data/models/list_item.dart';
import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/repositories/shared_preferences_repository.dart';

import 'package:flutter/material.dart';

class RecipeFormProvider extends ChangeNotifier {
  RecipeFormProvider({this.recipe});

  Recipe? recipe;
  bool _showImgPickerError = false;
  bool _showCategoryError = false;
  bool _showDifficultyError = false;
  bool isEditingRecipe = false;
  bool draftAvailable = false;
  String? imagePath;
  int? recentRecipeID;
  final formKey = GlobalKey<FormState>();
  SharedPreferencesRepository sharedPrefsRepo = SharedPreferencesRepository();

  Map<String, dynamic> complexInputValues = {
    "images": {
      "titleImg": "",
      "cookingDirectionImg": [],
    },
    "tags": <String>[],
    "ingredients": <ListItem>[],
    "directions": <CookingDirection>[]
  };

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

  void init(Recipe? recipeInput) async {
    print("init was called");
    recipe = recipeInput;
    isEditingRecipe = recipe != null;

    if (isEditingRecipe) {
      await loadRecentRecipeID();
      if (recipe?.id == recentRecipeID) {
        await loadCachedInput(isEditingRecipe);
      } else {
        await sharedPrefsRepo.deleteCachedEditInput();
      }
      loadRecipeDataForEditing();
    } else {
      await loadCachedInput(isEditingRecipe);
    }

    // WidgetsBinding.instance.addObserver(this);
    notifyListeners();
  }

  @override
  void dispose() {
    saveAllInputToList();
    for (var ctrlKey in allTextControllers.keys) {
      allTextControllers[ctrlKey]?.dispose();
    }
    super.dispose();
  }

  void cacheAllOnExit() {
    saveAllInputToList();
    // WidgetsBinding.instance.removeObserver(this);
  }

  Future<void> loadRecentRecipeID() async {
    recentRecipeID = await sharedPrefsRepo.recentID;
  }

  void loadRecipeDataForEditing() {
    allTextControllers["titleCtrl"]?.text = recipe!.title;
    allTextControllers["categoryCtrl"]?.text = recipe!.category;
    updateImage("titleImg", recipe!.images["titleImg"]);
    allTextControllers["difficultyCtrl"]?.text = recipe!.difficulty;

    complexInputValues["tags"] = recipe!.tags;
    allTextControllers["descCtrl"]?.text = recipe!.description;
    allTextControllers["prepTimeCtrl"]?.text = recipe!.prepTime.toString();
    allTextControllers["cookingTimeCtrl"]?.text = recipe!.cookingTime.toString();
    allTextControllers["notesCtrl"]?.text = recipe!.notes;
    complexInputValues["ingredients"] = recipe!.ingredients;
    complexInputValues["directions"] = recipe!.directions;
  }

  void saveAllInputToList() {
    // encode all simple types
    for (var key in allTextControllers.keys) {
      allInputFields[key] = allTextControllers[key]!.text;
    }

    // encode all complex types
    allInputFields["images"]["titleImg"] = complexInputValues["images"]["titleImg"];
    allInputFields["images"]["cookingDirectionImg"] = complexInputValues["images"]["cookingDirectionImg"];
    allInputFields["tags"] = complexInputValues["tags"];

    List<String> ingredientStringList = [];
    for (ListItem ingredient in complexInputValues["ingredients"]) {
      final ingredientMap = ingredient.toJson();
      ingredientStringList.add(jsonEncode(ingredientMap));
    }
    final String ingredientsEncoded = jsonEncode(ingredientStringList);
    allInputFields["ingredients"] = ingredientsEncoded;

    List<String> cookingDirectionStringList = [];
    for (CookingDirection direction in complexInputValues["directions"]) {
      final directionMap = direction.toJson();
      cookingDirectionStringList.add(jsonEncode(directionMap));
    }
    final String directionsEncoded = jsonEncode(cookingDirectionStringList);
    allInputFields["directions"] = directionsEncoded;

    final jsonString = jsonEncode(allInputFields);

    isEditingRecipe
        ? sharedPrefsRepo.overrideCachedEditInput(jsonString)
        : sharedPrefsRepo.overrideCachedInput(jsonString);
  }

  // check if json response contains actual values or nothing but empty strings, lists and maps or if an empty list is actually returned as a string: "[]"
  bool allValuesEmpty(dynamic value) {
    if (value is String) return value.trim().isEmpty || value == "[]";
    if (value is List) return value.isEmpty;
    if (value is Map) return value.isEmpty || value.values.every(allValuesEmpty);
    return false;
  }

  // load data from shared prefs into text controllers and complexInputValue map
  Future<void> loadCachedInput(isEditingRecipe) async {
    final jsonString =
        isEditingRecipe ? await sharedPrefsRepo.cachedEditRecipeInput : await sharedPrefsRepo.cachedNewRecipeInput;

    if (jsonString.isNotEmpty) {
      final decodedInput = jsonDecode(jsonString);
      bool jsonStringHasNoValues = allValuesEmpty(decodedInput);
      if (!jsonStringHasNoValues) {
        // decode all text input fields
        for (var key in allTextControllers.keys) {
          allTextControllers[key]!.text = decodedInput[key];
        }
        // decode title image
        if (decodedInput["images"]["titleImg"].isNotEmpty) {
          updateImage("titleImg", decodedInput["images"]["titleImg"]);
          complexInputValues["images"]["titleImg"] = decodedInput["images"]["titleImg"];
        }

        // decode ingredients
        final List<dynamic> ingredientList = jsonDecode(decodedInput["ingredients"]);

        final List<ListItem> decodedIngredientList = [];
        for (var ingredientItem in ingredientList) {
          Map ingredientDecoded = jsonDecode(ingredientItem);
          ListItem newListItem = ListItem(
            id: ingredientDecoded["id"],
            description: ingredientDecoded["description"],
            amount: ingredientDecoded["amount"],
            unit: ingredientDecoded["unit"],
          );
          decodedIngredientList.add(newListItem);
        }
        complexInputValues["ingredients"] = decodedIngredientList;

        // decode cooking directions
        final List<dynamic> cookingDirectionList = jsonDecode(decodedInput["directions"]);

        final List<CookingDirection> decodedDirectionList = [];
        for (var directionItem in cookingDirectionList) {
          Map directionDecoded = jsonDecode(directionItem);
          CookingDirection newDirection = CookingDirection(
            id: directionDecoded["id"],
            description: directionDecoded["description"],
          );
          decodedDirectionList.add(newDirection);
        }
        complexInputValues["directions"] = decodedDirectionList;

        // decode tags
        if (decodedInput["tags"].isNotEmpty) {
          List<String> tagList = decodedInput["tags"].cast<String>();
          complexInputValues["tags"] = tagList;
        }
        draftAvailable = true;
        notifyListeners();
      }
    }
  }

  void updateCategoryMenuError(bool showError) {
    _showCategoryError = showError;
    notifyListeners();
  }

  bool getCategoryErrorState() {
    return _showCategoryError;
  }

  void updateDifficultyMenuError(bool showError) {
    _showDifficultyError = showError;
    notifyListeners();
  }

  bool getDifficultyErrorState() {
    return _showDifficultyError;
  }

  void addIngredientToList() {
    complexInputValues["ingredients"].add(
      ListItem(
        description: allTextControllers["ingredientDescCtrl"]!.text,
        amount: double.tryParse(allTextControllers["ingredientAmountCtrl"]!.text),
        unit: allTextControllers["ingredientUnitCtrl"]!.text,
      ),
    );
    allTextControllers["ingredientAmountCtrl"]!.clear();
    allTextControllers["ingredientUnitCtrl"]!.clear();
    allTextControllers["ingredientDescCtrl"]!.clear();
    notifyListeners();
  }

  void removeFromIngredientList(int id) {
    complexInputValues["ingredients"].removeWhere((ingredient) => ingredient.id == id);
    notifyListeners();
  }

  void addCookingDirectionToList() {
    final directionDescription = allTextControllers["directionDescCtrl"]!.text;

    if (directionDescription != "") {
      CookingDirection newDirection = CookingDirection(description: directionDescription);

      complexInputValues["directions"].add(newDirection);
      allTextControllers["directionDescCtrl"]!.clear();
      notifyListeners();
    }
  }

  void removeCookingDirection(int id) {
    complexInputValues["directions"].removeWhere((direction) => direction.id == id);
    notifyListeners();
  }

  void addToTagsList() {
    final tagsTitle = allTextControllers["tagsCtrl"]!.text;
    if (allTextControllers["tagsCtrl"]!.text != "") {
      complexInputValues["tags"].add(tagsTitle);
      allTextControllers["tagsCtrl"]!.clear();
    }
    notifyListeners();
  }

  void removeFromTagsList(tagTitle) {
    complexInputValues["tags"].remove(tagTitle);
    notifyListeners();
  }

  void updateImage(String imagesKey, String imagePathFromPicker) {
    if (imagesKey == "titleImg") {
      complexInputValues["images"][imagesKey] = imagePathFromPicker;
      imagePath = imagePathFromPicker;
    }
  }

  void emptyImagePicker() {
    imagePath = null;
    complexInputValues["images"]["titleImg"] = "";
    updateImage("titleImg", "");
    _showImgPickerError = false;
    notifyListeners();
  }

  void resetAllCtrl() {
    print("resetAllCtrl");
    formKey.currentState?.reset();

    for (var key in allTextControllers.keys) {
      allTextControllers[key]!.clear();
    }
    _showImgPickerError = false;
    _showCategoryError = false;
    _showDifficultyError = false;

    complexInputValues = {
      "images": {
        "titleImg": "",
        "cookingDirectionImg": [],
      },
      "tags": <String>[],
      "ingredients": <ListItem>[],
      "directions": <CookingDirection>[]
    };
    emptyImagePicker();
    isEditingRecipe ? sharedPrefsRepo.deleteCachedEditInput() : sharedPrefsRepo.deleteCachedInput();
    draftAvailable = false;
    notifyListeners();
  }

  bool checkNoneTextfieldValues() {
    _showCategoryError = allTextControllers["categoryCtrl"]?.text.isEmpty ?? true;
    _showDifficultyError = allTextControllers["difficultyCtrl"]?.text.isEmpty ?? true;
    notifyListeners();

    String titleImg = complexInputValues["images"]["titleImg"];

    if (titleImg.isEmpty) {
      complexInputValues["images"]["titleImg"] = "assets/images/placeholder_recipe_img.jpg";
      notifyListeners();
    }

    if (_showCategoryError || _showDifficultyError || _showImgPickerError) {
      return false;
    } else {
      return true;
    }
  }
}
