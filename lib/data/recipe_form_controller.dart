import 'dart:convert';

import 'package:dishdrop_app_projekt/data/models/cooking_direction.dart';
import 'package:dishdrop_app_projekt/data/models/list_item.dart';
import 'package:dishdrop_app_projekt/data/repositories/shared_preferences_repository.dart';
import 'package:flutter/material.dart';

class RecipeFormController {
  final SharedPreferencesRepository sharedPrefs = SharedPreferencesRepository();

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

  final Map<String, dynamic> _complexInputValues = {
    "images": {
      "titleImg": "",
      "cookingDirectionImg": [],
    },
    "tags": <String>[],
    "ingredients": <ListItem>[],
    "directions": <CookingDirection>[]
  };

  void loadCachedInput() async {
    final jsonString = await sharedPrefs.cachedInput;

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
          // updateImage("titleImg", cachedInput["images"]["titleImg"]);
          _complexInputValues["images"]["titleImg"] = cachedInput["images"]["titleImg"];
        }

        // decode ingredients
        final List<dynamic> ingredientList = jsonDecode(cachedInput["ingredients"]);

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
        _complexInputValues["ingredients"] = decodedIngredientList;

        // decode cooking directions
        final List<dynamic> cookingDirectionList = jsonDecode(cachedInput["directions"]);

        final List<CookingDirection> decodedDirectionList = [];
        for (var directionItem in cookingDirectionList) {
          Map directionDecoded = jsonDecode(directionItem);
          CookingDirection newDirection = CookingDirection(
            id: directionDecoded["id"],
            description: directionDecoded["description"],
          );
          decodedDirectionList.add(newDirection);
        }
        _complexInputValues["directions"] = decodedDirectionList;

        // decode tags
        if (cachedInput["tags"].isNotEmpty) {
          List<String> tagList = cachedInput["tags"].cast<String>();
          _complexInputValues["tags"] = tagList;
        }
        // _draftAvailable = true;
        // setState(() {});
      }
    }
  }

  Map<String, dynamic> allInputFields = {
    "images": {
      "titleImg": "",
      "cookingDirectionImg": [],
    },
  };

  void saveAllInputToList() {
    // encode all simple types
    for (var key in allTextControllers.keys) {
      allInputFields[key] = allTextControllers[key]!.text;
    }

    // encode all complex types
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

    List<String> cookingDirectionStringList = [];
    for (CookingDirection direction in _complexInputValues["directions"]) {
      final directionMap = direction.toJson();
      cookingDirectionStringList.add(jsonEncode(directionMap));
    }
    final String directionsEncoded = jsonEncode(cookingDirectionStringList);
    allInputFields["directions"] = directionsEncoded;

    final jsonString = jsonEncode(allInputFields);
    sharedPrefs.overrideCachedInput(jsonString);
  }

  // check if json response contains actual values or nothing but empty strings, lists and maps or if an empty list is actually returned as a string: "[]"
  bool allValuesEmpty(dynamic value) {
    if (value is String) return value.trim().isEmpty || value == "[]";
    if (value is List) return value.isEmpty;
    if (value is Map) return value.isEmpty || value.values.every(allValuesEmpty);
    return false;
  }
}
