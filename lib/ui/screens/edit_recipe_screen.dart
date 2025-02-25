import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:dishdrop_app_projekt/core/utils/check_and_convert_amount.dart';
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
import 'package:dishdrop_app_projekt/ui/widgets/new_recipe_screen_widgets/cooking_directions_list_view.dart';
import 'package:dishdrop_app_projekt/ui/widgets/new_recipe_screen_widgets/image_picker_field.dart';
import 'package:dishdrop_app_projekt/ui/widgets/new_recipe_screen_widgets/image_url_text_form_field.dart';
import 'package:dishdrop_app_projekt/ui/widgets/new_recipe_screen_widgets/notes_text_form_field.dart';
import 'package:dishdrop_app_projekt/ui/widgets/new_recipe_screen_widgets/prep_time_text_form_field.dart';
import 'package:dishdrop_app_projekt/ui/widgets/new_recipe_screen_widgets/tags_text_form_field.dart';
import 'package:dishdrop_app_projekt/ui/widgets/new_recipe_screen_widgets/title_text_form_field.dart';
import 'package:flutter/material.dart';

class EditRecipeScreen extends StatefulWidget {
  const EditRecipeScreen({
    super.key,
    required this.recipeController,
    required this.shoppingListController,
  });
  final RecipeController recipeController;
  final ShoppingListController shoppingListController;

  @override
  State<EditRecipeScreen> createState() => _EditRecipeScreenState();
}

class _EditRecipeScreenState extends State<EditRecipeScreen> {
  // TODO: _allTextFormCtrl is currently passed down to every single field => only one specific ctrl needed in each case though
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

  final Map<String, dynamic> _userInputValues = {
    "title": "",
    "category": "",
    "images": {
      "titleImg": "",
      "cookingDirectionImg": [],
    },
    "difficulty": "",
    "tags": <String>[],
    "description": "",
    "prepTime": 0,
    "cookingTime": 0,
    "notes": "",
    "directions": <String>[],
    "ingredients": <ListItem>[],
  };
  double? _ingredientAmount = 0;
  String? _ingredientUnit = "";
  String _ingredientDescription = "";
  String _directionDescription = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit recipe",
            style: Theme.of(context).textTheme.headlineLarge),
      ),
      // body: Form(
      //   child: Padding(
      //     padding: const EdgeInsets.all(16.0),
      //     child: SingleChildScrollView(
      //       child: Column(
      //         spacing: 10,
      //         children: [
      //           TitleTextFormField(
      //               allTextFormCtrl: _allTextFormCtrl,
      //               userInputValues: _userInputValues),
      //           CategoryDropdownMenu(
      //               allTextFormCtrl: _allTextFormCtrl,
      //               userInputValues: _userInputValues),
      //           SizedBox(height: 30),
      //           ImagePickerField(),
      //           SizedBox(height: 30),
      //           ImageUrlTextFormField(
      //               allTextFormCtrl: _allTextFormCtrl,
      //               userInputValues: _userInputValues),
      //           DifficultyDropdownMenu(
      //               allTextFormCtrl: _allTextFormCtrl,
      //               userInputValues: _userInputValues),
      //           TagsTextFormField(allTextFormCtrl: _allTextFormCtrl),
      //           DescriptionTextFormField(
      //               allTextFormCtrl: _allTextFormCtrl,
      //               userInputValues: _userInputValues),
      //           Row(
      //             spacing: 10,
      //             children: [
      //               Expanded(
      //                 child: PrepTimeTextFormField(
      //                     allTextFormCtrl: _allTextFormCtrl,
      //                     userInputValues: _userInputValues),
      //               ),
      //               Expanded(
      //                 child: CookingTimeTextFormField(
      //                     allTextFormCtrl: _allTextFormCtrl,
      //                     userInputValues: _userInputValues),
      //               ),
      //             ],
      //           ),
      //           NotesTextFormField(
      //               allTextFormCtrl: _allTextFormCtrl,
      //               userInputValues: _userInputValues),
      //           SizedBox(height: 30),
      //           Row(
      //             children: [
      //               Text("Directions",
      //                   style: Theme.of(context).textTheme.headlineMedium),
      //               Spacer(),
      //             ],
      //           ),
      //           DirectionsListView(userInputValues: _userInputValues),
      //           Row(
      //             children: [
      //               Expanded(
      //                 child: TextFormField(
      //                   controller: _allTextFormCtrl["directionDescCtrl"],
      //                   onChanged: (value) => _directionDescription = value,
      //                   decoration: const InputDecoration(
      //                       border: OutlineInputBorder(),
      //                       hintText: "Add cooking directions"),
      //                 ),
      //               ),
      //               IconButton(
      //                   onPressed: () {
      //                     setState(() {
      //                       if (_directionDescription != "") {
      //                         _userInputValues["directions"]
      //                             .add(_directionDescription);
      //                         _allTextFormCtrl["directionDescCtrl"]!.clear();
      //                       }
      //                     });
      //                   },
      //                   icon: Icon(
      //                     Icons.add_box_outlined,
      //                     size: 35,
      //                   ))
      //             ],
      //           ),
      //           SizedBox(height: 30),
      //           Row(
      //             children: [
      //               Text("Ingredients",
      //                   style: Theme.of(context).textTheme.headlineMedium),
      //               Spacer(),
      //             ],
      //           ),
      //           Column(
      //             children: List.generate(
      //               _userInputValues["ingredients"].length,
      //               (index) {
      //                 return Container(
      //                   decoration: BoxDecoration(
      //                       color: index.isEven
      //                           ? AppColors.lightGrey
      //                           : Colors.white),
      //                   child: Padding(
      //                     padding: const EdgeInsets.all(8.0),
      //                     child: Row(
      //                       spacing: 10,
      //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                       crossAxisAlignment: CrossAxisAlignment.start,
      //                       children: [
      //                         Text(
      //                           "${checkAmountAndConvert(_userInputValues["ingredients"][index].amount)} ${_userInputValues["ingredients"][index].unit?.toString() ?? ''}",
      //                           style: Theme.of(context).textTheme.bodyLarge,
      //                         ),
      //                         Expanded(
      //                           child: Text(
      //                             _userInputValues["ingredients"][index]
      //                                 .description,
      //                             style: Theme.of(context).textTheme.bodyLarge,
      //                             textAlign: TextAlign.right,
      //                           ),
      //                         )
      //                       ],
      //                     ),
      //                   ),
      //                 );
      //               },
      //             ),
      //           ),
      //           SizedBox(height: 20),
      //           Row(
      //             children: [
      //               Expanded(
      //                 child: Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   spacing: 10,
      //                   children: [
      //                     TextFormField(
      //                       controller: _allTextFormCtrl["ingredientDescCtrl"],
      //                       onChanged: (value) =>
      //                           _ingredientDescription = value,
      //                       decoration: const InputDecoration(
      //                           border: OutlineInputBorder(),
      //                           hintText: "Ingredient description"),
      //                     ),
      //                     Row(
      //                       spacing: 10,
      //                       children: [
      //                         Expanded(
      //                           child: TextFormField(
      //                             controller:
      //                                 _allTextFormCtrl["ingredientAmountCtrl"],
      //                             onChanged: (value) => _ingredientAmount =
      //                                 double.tryParse(value),
      //                             decoration: const InputDecoration(
      //                               filled: true,
      //                               fillColor: AppColors.lightGrey,
      //                               border: OutlineInputBorder(),
      //                               hintText: "Amount",
      //                             ),
      //                           ),
      //                         ),
      //                         Expanded(
      //                           child: TextFormField(
      //                             controller:
      //                                 _allTextFormCtrl["ingredientUnitCtrl"],
      //                             onChanged: (value) => value == ""
      //                                 ? _ingredientUnit = null
      //                                 : _ingredientUnit = value,
      //                             decoration: const InputDecoration(
      //                                 border: OutlineInputBorder(),
      //                                 hintText: "Unit"),
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                     Text(
      //                       "You can enter fractional amounts like 1½ as 1.5",
      //                       style: Theme.of(context)
      //                           .textTheme
      //                           .labelMedium
      //                           ?.copyWith(fontStyle: FontStyle.italic),
      //                     )
      //                   ],
      //                 ),
      //               ),
      //               IconButton(
      //                   onPressed: () {
      //                     setState(() {
      //                       _userInputValues["ingredients"].add(
      //                         ListItem(
      //                           description: _ingredientDescription,
      //                           amount: _ingredientAmount,
      //                           unit: _ingredientUnit,
      //                         ),
      //                       );
      //                       _allTextFormCtrl["ingredientAmountCtrl"]!.clear();
      //                       _allTextFormCtrl["ingredientUnitCtrl"]!.clear();
      //                       _allTextFormCtrl["ingredientDescCtrl"]!.clear();
      //                     });
      //                   },
      //                   icon: Icon(
      //                     Icons.add_box_outlined,
      //                     size: 35,
      //                   ))
      //             ],
      //           ),
      //           SizedBox(height: 5),
      //           Row(
      //             children: [
      //               TextButton(
      //                 style: TextButton.styleFrom(foregroundColor: Colors.red),
      //                 onPressed: () => resetAllCtrl(),
      //                 child: Text("Reset all fields"),
      //               ),
      //             ],
      //           ),
      //           SizedBox(height: 30),
      //           Row(
      //             spacing: 10,
      //             children: [
      //               FilledButton(
      //                 onPressed: () {
      //                   Recipe newRecipe = prepareRecipeForDb(_userInputValues);
      //                   widget.recipeController.addRecipe(newRecipe);
      //                   showCustomAlertBanner(
      //                       context, Colors.green, "Recipe added to cookbook!");
      //                 },
      //                 child: Text("Save recipe"),
      //               ),
      //               FilledButton(
      //                 onPressed: () {
      //                   Recipe newRecipe = prepareRecipeForDb(_userInputValues);
      //                   widget.recipeController.addRecipe(newRecipe);
      //                   showCustomAlertBanner(
      //                       context, Colors.green, "Recipe added to cookbook!");
      //                   Navigator.of(context).push(
      //                     MaterialPageRoute(
      //                       builder: (BuildContext context) =>
      //                           RecipeDetailsScreen(
      //                               recipe: newRecipe,
      //                               recipeController: widget.recipeController,
      //                               shoppingListController:
      //                                   widget.shoppingListController),
      //                     ),
      //                   );
      //                 },
      //                 child: Text("Save and open recipe"),
      //               )
      //             ],
      //           ),
      //           SizedBox(height: 100),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }

  Recipe prepareRecipeForDb(Map<String, dynamic> userInputValues) {
    Recipe newRecipe = Recipe(
      title: userInputValues["title"],
      category: userInputValues["category"],
      description: userInputValues["description"],
      notes: userInputValues["notes"],
      difficulty: userInputValues["difficulty"],
      tags: userInputValues["tags"],
      images: userInputValues["images"],
      prepTime: userInputValues["prepTime"],
      cookingTime: userInputValues["cookingTime"],
      directions: userInputValues["directions"],
      ingredients: userInputValues["ingredients"],
    );

    resetAllCtrl();
    return newRecipe;
  }

  void resetAllCtrl() {
    for (var key in _allTextFormCtrl.keys) {
      _allTextFormCtrl[key]!.clear();
    }
  }
}
