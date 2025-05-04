// import 'package:dishdrop_app_projekt/data/models/cooking_direction.dart';
// import 'package:dishdrop_app_projekt/data/models/list_item.dart';
// import 'package:dishdrop_app_projekt/data/models/recipe.dart';

// import 'package:dishdrop_app_projekt/data/recipe_form_controller.dart';
// import 'package:dishdrop_app_projekt/data/repositories/shared_preferences_repository.dart';

// import 'package:dishdrop_app_projekt/ui/widgets/recipe_form_screen_widgets/category_dropdown_menu.dart';
// import 'package:dishdrop_app_projekt/ui/widgets/recipe_form_screen_widgets/cooking_time_text_form_field.dart';
// import 'package:dishdrop_app_projekt/ui/widgets/recipe_form_screen_widgets/description_text_form_field.dart';
// import 'package:dishdrop_app_projekt/ui/widgets/recipe_form_screen_widgets/difficulty_dropdown_menu.dart';
// import 'package:dishdrop_app_projekt/ui/widgets/recipe_form_screen_widgets/cooking_directions_list_view.dart';
// import 'package:dishdrop_app_projekt/ui/widgets/recipe_form_screen_widgets/image_picker_field.dart';

// import 'package:dishdrop_app_projekt/ui/widgets/recipe_form_screen_widgets/notes_text_form_field.dart';
// import 'package:dishdrop_app_projekt/ui/widgets/recipe_form_screen_widgets/prep_time_text_form_field.dart';
// import 'package:dishdrop_app_projekt/ui/widgets/recipe_form_screen_widgets/cooking_direction_input_section.dart';
// import 'package:dishdrop_app_projekt/ui/widgets/recipe_form_screen_widgets/footer_button_section.dart';
// import 'package:dishdrop_app_projekt/ui/widgets/recipe_form_screen_widgets/ingredient_input_section.dart';
// import 'package:dishdrop_app_projekt/ui/widgets/recipe_form_screen_widgets/ingredient_list_view.dart';
// import 'package:dishdrop_app_projekt/ui/widgets/recipe_form_screen_widgets/tags_list_view.dart';
// import 'package:dishdrop_app_projekt/ui/widgets/recipe_form_screen_widgets/tags_text_form_field.dart';
// import 'package:dishdrop_app_projekt/ui/widgets/recipe_form_screen_widgets/title_text_form_field.dart';
// import 'package:flutter/material.dart';
// import 'dart:convert';

// class RecipeFormScreen extends StatefulWidget {
//   const RecipeFormScreen({
//     super.key,
//     this.recipe,
//   });

//   final Recipe? recipe;

//   @override
//   State<RecipeFormScreen> createState() => _RecipeFormScreenState();
// }

// class _RecipeFormScreenState extends State<RecipeFormScreen> with WidgetsBindingObserver {
//   final formKey = GlobalKey<FormState>();
//   RecipeFormController recipeFormController = RecipeFormController();
//   SharedPreferencesRepository sharedPreferencesRepository = SharedPreferencesRepository();

//   bool _showImgPickerError = false;
//   bool _showCategoryError = false;
//   bool _showDifficultyError = false;
//   bool _draftAvailable = false;
//   bool isEditingRecipe = false;
//   String? imagePath;
//   int? recentRecipeID;
//   bool isLoading = false;
//   Map<String, dynamic> allInputFields = {
//     "images": {
//       "titleImg": "",
//       "cookingDirectionImg": [],
//     },
//   };

//   final Map<String, TextEditingController> allTextControllers = {
//     "titleCtrl": TextEditingController(),
//     "categoryCtrl": TextEditingController(),
//     "difficultyCtrl": TextEditingController(),
//     "tagsCtrl": TextEditingController(),
//     "descCtrl": TextEditingController(),
//     "prepTimeCtrl": TextEditingController(),
//     "cookingTimeCtrl": TextEditingController(),
//     "notesCtrl": TextEditingController(),
//     "ingredientAmountCtrl": TextEditingController(),
//     "ingredientUnitCtrl": TextEditingController(),
//     "ingredientDescCtrl": TextEditingController(),
//     "directionDescCtrl": TextEditingController(),
//   };

//   Map<String, dynamic> complexInputValues = {
//     "images": {
//       "titleImg": "",
//       "cookingDirectionImg": [],
//     },
//     "tags": <String>[],
//     "ingredients": <ListItem>[],
//     "directions": <CookingDirection>[]
//   };

//   @override
//   void initState() {
//     super.initState();

//     if (widget.recipe != null) {
//       isEditingRecipe = true;
//     }

//     if (isEditingRecipe && widget.recipe != null) {
//       loadRecentRecipeID();
//       if (widget.recipe?.id == recentRecipeID) {
//         loadCachedInput(isEditingRecipe);
//       } else {
//         sharedPreferencesRepository.deleteCachedEditInput();
//       }
//       loadRecipeDataForEditing();
//     } else {
//       loadCachedInput(isEditingRecipe);
//     }

//     // WidgetsBinding.instance.addObserver(this);
//     setState(() {});
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     saveAllInputToList();
//     // WidgetsBinding.instance.removeObserver(this);
//     for (var ctrlKey in allTextControllers.keys) {
//       allTextControllers[ctrlKey]?.dispose();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return isLoading
//         ? CircularProgressIndicator()
//         : GestureDetector(
//             onTap: () => FocusScope.of(context).unfocus(),
//             child: Scaffold(
//               appBar: AppBar(
//                 title: Text(isEditingRecipe ? "Edit recipe" : "New recipe",
//                     style: Theme.of(context).textTheme.headlineLarge),
//                 actions: [
//                   if (_draftAvailable)
//                     TextButton(
//                       onPressed: () {
//                         resetAllCtrl(allTextControllers, formKey);
//                       },
//                       child: Text(
//                         "Delete Draft",
//                         style: TextStyle(color: Colors.red),
//                       ),
//                     )
//                 ],
//               ),
//               body: Form(
//                 key: formKey,
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       spacing: 10,
//                       children: [
//                         TitleTextFormField(
//                           titleCtrl: allTextControllers["titleCtrl"]!,
//                         ),
//                         CategoryDropdownMenu(
//                           categoryCtrl: allTextControllers["categoryCtrl"]!,
//                           showErrorFunc: updateCategoryMenuError,
//                           getErrorStateFunc: getCategoryErrorState,
//                         ),
//                         SizedBox(height: 30),
//                         ImagePickerField(
//                           updateImagesFunc: updateImage,
//                           emptyImgPickerFunc: emptyImagePicker,
//                           imagePath: imagePath,
//                         ),
//                         SizedBox(height: 20),
//                         DifficultyDropdownMenu(
//                           difficultyCtrl: allTextControllers["difficultyCtrl"]!,
//                           showErrorFunc: updateDifficultyMenuError,
//                           getErrorStateFunc: getDifficultyErrorState,
//                         ),
//                         TagsInputSection(
//                           complexInputValues: complexInputValues,
//                           tagsCtrl: allTextControllers["tagsCtrl"]!,
//                           updateTagsList: addToTagsList,
//                         ),
//                         TagsListView(
//                           complexInputValues: complexInputValues,
//                           removeFromTagsList: removeFromTagsList,
//                         ),
//                         SizedBox(height: 20),
//                         DescriptionTextFormField(descCtrl: allTextControllers["descCtrl"]!),
//                         Row(
//                           spacing: 10,
//                           children: [
//                             Expanded(
//                               child: PrepTimeTextFormField(prepTimeCtrl: allTextControllers["prepTimeCtrl"]!),
//                             ),
//                             Expanded(
//                               child: CookingTimeTextFormField(cookingTimeCtrl: allTextControllers["cookingTimeCtrl"]!),
//                             ),
//                           ],
//                         ),
//                         NotesTextFormField(notesCtrl: allTextControllers["notesCtrl"]!),
//                         SizedBox(height: 30),
//                         Text("Cooking Directions", style: Theme.of(context).textTheme.headlineMedium),
//                         CookingDirectionsListView(
//                           complexInputValues: complexInputValues,
//                           removeFromCookingDirectionsListFunc: removeCookingDirection,
//                         ),
//                         CookingDirectionInputSection(
//                           complexInputValues: complexInputValues,
//                           cookingDirectionCtrl: allTextControllers["directionDescCtrl"]!,
//                           addCookingDirectionFunc: addCookingDirectionToList,
//                         ),
//                         SizedBox(height: 30),
//                         Text("Ingredients", style: Theme.of(context).textTheme.headlineMedium),
//                         IngredientListView(
//                           complexInputValues: complexInputValues,
//                           removeFromListFunc: removeFromIngredientList,
//                         ),
//                         if (complexInputValues["ingredients"].isNotEmpty) SizedBox(height: 20),
//                         IngredientInputSection(
//                           allTextFormCtrl: allTextControllers,
//                           complexInputValues: complexInputValues,
//                           addIngredientFunc: addIngredientToList,
//                         ),
//                         SizedBox(height: 30),
//                         ElevatedButton(
//                           style: TextButton.styleFrom(foregroundColor: Colors.red),
//                           onPressed: () => resetAllCtrl(allTextControllers, formKey),
//                           child: Text("Reset all fields"),
//                         ),
//                         SizedBox(height: 10),
//                         FooterButtonSection(
//                           complexInputValues: complexInputValues,
//                           widget: widget,
//                           allTextFormCtrl: allTextControllers,
//                           formKey: formKey,
//                           checkNoneTextFieldValuesFunc: checkNoneTextfieldValues,
//                           resetAllCtrl: resetAllCtrl,
//                           isEditingRecipe: isEditingRecipe,
//                         ),
//                         SizedBox(height: 100),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//   }

//   Future<void> loadRecentRecipeID() async {
//     recentRecipeID = await sharedPreferencesRepository.recentID;
//   }

//   void loadRecipeDataForEditing() {
//     allTextControllers["titleCtrl"]?.text = widget.recipe!.title;
//     allTextControllers["categoryCtrl"]?.text = widget.recipe!.category;
//     updateImage("titleImg", widget.recipe!.images["titleImg"]);
//     allTextControllers["difficultyCtrl"]?.text = widget.recipe!.difficulty;

//     complexInputValues["tags"] = widget.recipe!.tags;
//     allTextControllers["descCtrl"]?.text = widget.recipe!.description;
//     allTextControllers["prepTimeCtrl"]?.text = widget.recipe!.prepTime.toString();
//     allTextControllers["cookingTimeCtrl"]?.text = widget.recipe!.cookingTime.toString();
//     allTextControllers["notesCtrl"]?.text = widget.recipe!.notes;
//     complexInputValues["ingredients"] = widget.recipe!.ingredients;
//     complexInputValues["directions"] = widget.recipe!.directions;
//   }

//   void saveAllInputToList() {
//     // encode all simple types
//     for (var key in allTextControllers.keys) {
//       allInputFields[key] = allTextControllers[key]!.text;
//     }

//     // encode all complex types
//     allInputFields["images"]["titleImg"] = complexInputValues["images"]["titleImg"];
//     allInputFields["images"]["cookingDirectionImg"] = complexInputValues["images"]["cookingDirectionImg"];
//     allInputFields["tags"] = complexInputValues["tags"];

//     List<String> ingredientStringList = [];
//     for (ListItem ingredient in complexInputValues["ingredients"]) {
//       final ingredientMap = ingredient.toJson();
//       ingredientStringList.add(jsonEncode(ingredientMap));
//     }
//     final String ingredientsEncoded = jsonEncode(ingredientStringList);
//     allInputFields["ingredients"] = ingredientsEncoded;

//     List<String> cookingDirectionStringList = [];
//     for (CookingDirection direction in complexInputValues["directions"]) {
//       final directionMap = direction.toJson();
//       cookingDirectionStringList.add(jsonEncode(directionMap));
//     }
//     final String directionsEncoded = jsonEncode(cookingDirectionStringList);
//     allInputFields["directions"] = directionsEncoded;

//     final jsonString = jsonEncode(allInputFields);
//     isEditingRecipe
//         ? sharedPreferencesRepository.overrideCachedEditInput(jsonString)
//         : sharedPreferencesRepository.overrideCachedInput(jsonString);
//   }

//   // check if json response contains actual values or nothing but empty strings, lists and maps or if an empty list is actually returned as a string: "[]"
//   bool allValuesEmpty(dynamic value) {
//     if (value is String) return value.trim().isEmpty || value == "[]";
//     if (value is List) return value.isEmpty;
//     if (value is Map) return value.isEmpty || value.values.every(allValuesEmpty);
//     return false;
//   }

//   // load data from shared prefs into text controllers and complexInputValue map
//   void loadCachedInput(isEditingRecipe) async {
//     final jsonString = isEditingRecipe
//         ? await sharedPreferencesRepository.cachedEditRecipeInput
//         : await sharedPreferencesRepository.cachedNewRecipeInput;

//     if (jsonString.isNotEmpty) {
//       final decodedInput = jsonDecode(jsonString);
//       bool jsonStringHasNoValues = allValuesEmpty(decodedInput);
//       if (!jsonStringHasNoValues) {
//         // decode all text input fields
//         for (var key in allTextControllers.keys) {
//           allTextControllers[key]!.text = decodedInput[key];
//         }
//         // decode title image
//         if (decodedInput["images"]["titleImg"].isNotEmpty) {
//           updateImage("titleImg", decodedInput["images"]["titleImg"]);
//           complexInputValues["images"]["titleImg"] = decodedInput["images"]["titleImg"];
//         }

//         // decode ingredients
//         final List<dynamic> ingredientList = jsonDecode(decodedInput["ingredients"]);

//         final List<ListItem> decodedIngredientList = [];
//         for (var ingredientItem in ingredientList) {
//           Map ingredientDecoded = jsonDecode(ingredientItem);
//           ListItem newListItem = ListItem(
//             id: ingredientDecoded["id"],
//             description: ingredientDecoded["description"],
//             amount: ingredientDecoded["amount"],
//             unit: ingredientDecoded["unit"],
//           );
//           decodedIngredientList.add(newListItem);
//         }
//         complexInputValues["ingredients"] = decodedIngredientList;

//         // decode cooking directions
//         final List<dynamic> cookingDirectionList = jsonDecode(decodedInput["directions"]);

//         final List<CookingDirection> decodedDirectionList = [];
//         for (var directionItem in cookingDirectionList) {
//           Map directionDecoded = jsonDecode(directionItem);
//           CookingDirection newDirection = CookingDirection(
//             id: directionDecoded["id"],
//             description: directionDecoded["description"],
//           );
//           decodedDirectionList.add(newDirection);
//         }
//         complexInputValues["directions"] = decodedDirectionList;

//         // decode tags
//         if (decodedInput["tags"].isNotEmpty) {
//           List<String> tagList = decodedInput["tags"].cast<String>();
//           complexInputValues["tags"] = tagList;
//         }
//         _draftAvailable = true;
//         setState(() {});
//       }
//     }
//   }

//   void updateCategoryMenuError(bool showError) {
//     _showCategoryError = showError;
//   }

//   bool getCategoryErrorState() {
//     return _showCategoryError;
//   }

//   void updateDifficultyMenuError(bool showError) {
//     _showDifficultyError = showError;
//   }

//   bool getDifficultyErrorState() {
//     return _showDifficultyError;
//   }

//   void addIngredientToList() {
//     setState(() {
//       complexInputValues["ingredients"].add(
//         ListItem(
//           description: allTextControllers["ingredientDescCtrl"]!.text,
//           amount: double.tryParse(allTextControllers["ingredientAmountCtrl"]!.text),
//           unit: allTextControllers["ingredientUnitCtrl"]!.text,
//         ),
//       );
//       allTextControllers["ingredientAmountCtrl"]!.clear();
//       allTextControllers["ingredientUnitCtrl"]!.clear();
//       allTextControllers["ingredientDescCtrl"]!.clear();
//     });
//   }

//   void removeFromIngredientList(int id) {
//     setState(() {
//       complexInputValues["ingredients"].removeWhere((ingredient) => ingredient.id == id);
//     });
//   }

//   void addCookingDirectionToList() {
//     final directionDescription = allTextControllers["directionDescCtrl"]!.text;
//     setState(
//       () {
//         if (directionDescription != "") {
//           CookingDirection newDirection = CookingDirection(description: directionDescription);

//           complexInputValues["directions"].add(newDirection);
//           allTextControllers["directionDescCtrl"]!.clear();
//         }
//       },
//     );
//   }

//   void removeCookingDirection(int id) {
//     setState(() {
//       complexInputValues["directions"].removeWhere((direction) => direction.id == id);
//     });
//   }

//   void addToTagsList() {
//     final tagsTitle = allTextControllers["tagsCtrl"]!.text;
//     setState(() {
//       if (allTextControllers["tagsCtrl"]!.text != "") {
//         complexInputValues["tags"].add(tagsTitle);
//         allTextControllers["tagsCtrl"]!.clear();
//       }
//     });
//   }

//   void removeFromTagsList(tagTitle) {
//     setState(() {
//       complexInputValues["tags"].remove(tagTitle);
//     });
//   }

//   void updateImage(String imagesKey, String imagePathFromPicker) {
//     if (imagesKey == "titleImg") {
//       complexInputValues["images"][imagesKey] = imagePathFromPicker;
//       imagePath = imagePathFromPicker;
//     }
//   }

//   void emptyImagePicker() {
//     setState(() {
//       imagePath = null;
//       complexInputValues["images"]["titleImg"] = "";
//       updateImage("titleImg", "");
//       _showImgPickerError = false;
//     });
//   }

//   void resetAllCtrl(Map<String, TextEditingController> allTextFormCtrl, formKey) {
//     if (formKey != null) {
//       formKey.currentState?.reset();
//     }
//     for (var key in allTextFormCtrl.keys) {
//       allTextFormCtrl[key]!.clear();
//     }
//     _showImgPickerError = false;
//     _showCategoryError = false;
//     _showDifficultyError = false;

//     complexInputValues = {
//       "images": {
//         "titleImg": "",
//         "cookingDirectionImg": [],
//       },
//       "tags": <String>[],
//       "ingredients": <ListItem>[],
//       "directions": <String>[]
//     };
//     emptyImagePicker();
//     isEditingRecipe
//         ? sharedPreferencesRepository.deleteCachedEditInput()
//         : sharedPreferencesRepository.deleteCachedInput();
//     _draftAvailable = false;
//     setState(() {});
//   }

//   bool checkNoneTextfieldValues(Map<String, TextEditingController> allTextFormCtrl, complexInputValues) {
//     setState(() {
//       _showCategoryError = allTextFormCtrl["categoryCtrl"]?.text.isEmpty ?? true;
//       _showDifficultyError = allTextFormCtrl["difficultyCtrl"]?.text.isEmpty ?? true;
//     });

//     String titleImg = complexInputValues["images"]["titleImg"];

//     if (titleImg.isEmpty) {
//       setState(() {
//         complexInputValues["images"]["titleImg"] = "assets/images/placeholder_recipe_img.jpg";
//       });
//     }

//     if (_showCategoryError || _showDifficultyError || _showImgPickerError) {
//       return false;
//     } else {
//       return true;
//     }
//   }
// }
