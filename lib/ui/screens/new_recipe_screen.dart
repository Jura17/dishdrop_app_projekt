import 'package:alert_banner/exports.dart';
import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:dishdrop_app_projekt/data/models/list_item.dart';
import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/repositories/mock_database.dart';
import 'package:flutter/material.dart';

class NewRecipeScreen extends StatefulWidget {
  const NewRecipeScreen({super.key, required this.db});
  final MockDatabase db;

  @override
  State<NewRecipeScreen> createState() => _NewRecipeScreenState();
}

class _NewRecipeScreenState extends State<NewRecipeScreen> {
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
        title: Text("New recipe",
            style: Theme.of(context).textTheme.headlineLarge),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              spacing: 10,
              children: [
                TitleField(
                    allTextFormCtrl: _allTextFormCtrl,
                    userInputValues: _userInputValues),
                CategoryDropdownMenu(
                    allTextFormCtrl: _allTextFormCtrl,
                    userInputValues: _userInputValues),
                SizedBox(height: 30),
                ImagePickerField(),
                SizedBox(height: 30),
                ImageUrlField(
                    allTextFormCtrl: _allTextFormCtrl,
                    userInputValues: _userInputValues),
                DifficultyDropdownMenu(
                    allTextFormCtrl: _allTextFormCtrl,
                    userInputValues: _userInputValues),
                TagsField(allTextFormCtrl: _allTextFormCtrl),
                DescriptionField(
                    allTextFormCtrl: _allTextFormCtrl,
                    userInputValues: _userInputValues),
                Row(
                  spacing: 10,
                  children: [
                    Expanded(
                      child: PrepTimeField(
                          allTextFormCtrl: _allTextFormCtrl,
                          userInputValues: _userInputValues),
                    ),
                    Expanded(
                      child: CookingTimeField(
                          allTextFormCtrl: _allTextFormCtrl,
                          userInputValues: _userInputValues),
                    ),
                  ],
                ),
                NotesField(
                    allTextFormCtrl: _allTextFormCtrl,
                    userInputValues: _userInputValues),
                SizedBox(height: 30),
                Row(
                  children: [
                    Text("Directions",
                        style: Theme.of(context).textTheme.headlineMedium),
                    Spacer(),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    _userInputValues["directions"].length,
                    (index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${index + 1}. ",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Expanded(
                              child: Text(
                                _userInputValues["directions"][index],
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _allTextFormCtrl["directionDescCtrl"],
                        onChanged: (value) => _directionDescription = value,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Add cooking directions"),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            if (_directionDescription != "") {
                              _userInputValues["directions"]
                                  .add(_directionDescription);
                              _allTextFormCtrl["directionDescCtrl"]!.clear();
                            }
                          });
                        },
                        icon: Icon(
                          Icons.add_box_outlined,
                          size: 35,
                        ))
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Text("Ingredients",
                        style: Theme.of(context).textTheme.headlineMedium),
                    Spacer(),
                  ],
                ),
                Column(
                  children: List.generate(
                      _userInputValues["ingredients"].length, (index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: index.isEven ? AppColors.lightGrey : null),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          spacing: 10,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${_userInputValues["ingredients"][index].amount?.toString() ?? ''} ${_userInputValues["ingredients"][index].unit?.toString() ?? ''}",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Expanded(
                              child: Text(
                                _userInputValues["ingredients"][index]
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
                            onChanged: (value) =>
                                _ingredientDescription = value,
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
                                  onChanged: (value) => _ingredientAmount =
                                      double.tryParse(value),
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
                                  onChanged: (value) => value == ""
                                      ? _ingredientUnit = null
                                      : _ingredientUnit = value,
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
                            _userInputValues["ingredients"].add(
                              ListItem(
                                description: _ingredientDescription,
                                amount: _ingredientAmount,
                                unit: _ingredientUnit,
                              ),
                            );
                            _allTextFormCtrl["ingredientAmountCtrl"]!.clear();
                            _allTextFormCtrl["ingredientUnitCtrl"]!.clear();
                            _allTextFormCtrl["ingredientDescCtrl"]!.clear();
                          });
                        },
                        icon: Icon(
                          Icons.add_box_outlined,
                          size: 35,
                        ))
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(foregroundColor: Colors.red),
                      onPressed: () => resetAllCtrl(),
                      child: Text("Reset all fields"),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  spacing: 10,
                  children: [
                    FilledButton(
                      onPressed: () {
                        addRecipeToDb(_userInputValues);
                      },
                      child: Text("Save recipe"),
                    ),
                    FilledButton(
                      onPressed: () {
                        addRecipeToDb(_userInputValues);
                        Navigator.of(context).pop();
                      },
                      child: Text("Save and open recipe"),
                    )
                  ],
                ),
                SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addRecipeToDb(Map<String, dynamic> userInputValues) {
    Recipe newRecipe = Recipe(
      title: userInputValues["title"],
      category: userInputValues["category"],
      description: userInputValues["description"],
      difficulty: userInputValues["difficulty"],
      tags: userInputValues["tags"],
      images: userInputValues["images"],
      prepTime: userInputValues["prepTime"],
      cookingTime: userInputValues["cookingTime"],
      directions: userInputValues["directions"],
      ingredients: userInputValues["ingredients"],
    );

    widget.db.addRecipe(newRecipe);
    showAlertBanner(
        context,
        () {},
        Container(
          color: Colors.green,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              textAlign: TextAlign.center,
              "Success! Recipe added to cookbook.",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        alertBannerLocation: AlertBannerLocation.bottom);
    resetAllCtrl();
  }

  void resetAllCtrl() {
    for (var key in _allTextFormCtrl.keys) {
      _allTextFormCtrl[key]!.clear();
    }
  }
}

class NotesField extends StatelessWidget {
  const NotesField({
    super.key,
    required Map<String, TextEditingController> allTextFormCtrl,
    required Map<String, dynamic> userInputValues,
  })  : _allTextFormCtrl = allTextFormCtrl,
        _userInputValues = userInputValues;

  final Map<String, TextEditingController> _allTextFormCtrl;
  final Map<String, dynamic> _userInputValues;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _allTextFormCtrl["notesCtrl"],
      onChanged: (value) => _userInputValues["notes"] = value,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Notes",
        contentPadding: EdgeInsets.symmetric(vertical: 50, horizontal: 16),
      ),
    );
  }
}

class CookingTimeField extends StatelessWidget {
  const CookingTimeField({
    super.key,
    required Map<String, TextEditingController> allTextFormCtrl,
    required Map<String, dynamic> userInputValues,
  })  : _allTextFormCtrl = allTextFormCtrl,
        _userInputValues = userInputValues;

  final Map<String, TextEditingController> _allTextFormCtrl;
  final Map<String, dynamic> _userInputValues;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _allTextFormCtrl["cookingTimeCtrl"],
      onChanged: (value) =>
          _userInputValues["cookingTime"] = int.tryParse(value),
      decoration: const InputDecoration(
          border: OutlineInputBorder(), hintText: "Cooking Time"),
    );
  }
}

class PrepTimeField extends StatelessWidget {
  const PrepTimeField({
    super.key,
    required Map<String, TextEditingController> allTextFormCtrl,
    required Map<String, dynamic> userInputValues,
  })  : _allTextFormCtrl = allTextFormCtrl,
        _userInputValues = userInputValues;

  final Map<String, TextEditingController> _allTextFormCtrl;
  final Map<String, dynamic> _userInputValues;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _allTextFormCtrl["prepTimeCtrl"],
      onChanged: (value) => _userInputValues["prepTime"] = int.tryParse(value),
      decoration: const InputDecoration(
          filled: true,
          fillColor: AppColors.lightGrey,
          border: OutlineInputBorder(),
          hintText: "Prep Time"),
    );
  }
}

class DescriptionField extends StatelessWidget {
  const DescriptionField({
    super.key,
    required Map<String, TextEditingController> allTextFormCtrl,
    required Map<String, dynamic> userInputValues,
  })  : _allTextFormCtrl = allTextFormCtrl,
        _userInputValues = userInputValues;

  final Map<String, TextEditingController> _allTextFormCtrl;
  final Map<String, dynamic> _userInputValues;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _allTextFormCtrl["descCtrl"],
      onChanged: (value) => _userInputValues["description"] = value,
      decoration: const InputDecoration(
        hintText: "Description",
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(vertical: 50, horizontal: 16),
      ),
    );
  }
}

class TagsField extends StatelessWidget {
  const TagsField({
    super.key,
    required Map<String, TextEditingController> allTextFormCtrl,
  }) : _allTextFormCtrl = allTextFormCtrl;

  final Map<String, TextEditingController> _allTextFormCtrl;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _allTextFormCtrl["tagsCtrl"],
      decoration: const InputDecoration(
        hintText: "Tags",
        border: OutlineInputBorder(),
      ),
    );
  }
}

class DifficultyDropdownMenu extends StatelessWidget {
  const DifficultyDropdownMenu({
    super.key,
    required Map<String, TextEditingController> allTextFormCtrl,
    required Map<String, dynamic> userInputValues,
  })  : _allTextFormCtrl = allTextFormCtrl,
        _userInputValues = userInputValues;

  final Map<String, TextEditingController> _allTextFormCtrl;
  final Map<String, dynamic> _userInputValues;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      controller: _allTextFormCtrl["difficultyCtrl"],
      onSelected: (value) => _userInputValues["difficulty"] = value,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
      width: double.infinity,
      dropdownMenuEntries: [
        DropdownMenuEntry(value: "Simple", label: "Simple"),
        DropdownMenuEntry(value: "Not Too Tricky", label: "Not Too Tricky"),
        DropdownMenuEntry(value: "Impressive", label: "Impressive"),
      ],
      hintText: "Select difficulty",
    );
  }
}

class ImageUrlField extends StatelessWidget {
  const ImageUrlField({
    super.key,
    required Map<String, TextEditingController> allTextFormCtrl,
    required Map<String, dynamic> userInputValues,
  })  : _allTextFormCtrl = allTextFormCtrl,
        _userInputValues = userInputValues;

  final Map<String, TextEditingController> _allTextFormCtrl;
  final Map<String, dynamic> _userInputValues;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _allTextFormCtrl["imgUrlCtrl"],
      onChanged: (value) => _userInputValues["images"]["titleImg"] = value,
      decoration: const InputDecoration(
        filled: true,
        fillColor: AppColors.lightGrey,
        hintText: "Image-URL",
        border: OutlineInputBorder(),
      ),
    );
  }
}

class ImagePickerField extends StatelessWidget {
  const ImagePickerField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // TODO: implement image picker here
      onTap: () {},
      child: Container(
        width: 250,
        height: 250,
        decoration: BoxDecoration(
          color: AppColors.lightGrey,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.dishDropBlack),
        ),
        child: Icon(
          Icons.camera_alt_outlined,
          size: 50,
          color: AppColors.dishDropBlack,
        ),
      ),
    );
  }
}

class CategoryDropdownMenu extends StatelessWidget {
  const CategoryDropdownMenu({
    super.key,
    required Map<String, TextEditingController> allTextFormCtrl,
    required Map<String, dynamic> userInputValues,
  })  : _allTextFormCtrl = allTextFormCtrl,
        _userInputValues = userInputValues;

  final Map<String, TextEditingController> _allTextFormCtrl;
  final Map<String, dynamic> _userInputValues;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      controller: _allTextFormCtrl["categoryCtrl"],
      onSelected: (value) => _userInputValues["category"] = value,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
      width: double.infinity,
      dropdownMenuEntries: [
        DropdownMenuEntry(value: "Appetizers", label: "Appetizers"),
        DropdownMenuEntry(value: "Main Courses", label: "Main Courses"),
        DropdownMenuEntry(value: "Side Dishes", label: "Side Dishes"),
        DropdownMenuEntry(value: "Salads", label: "Salads"),
        DropdownMenuEntry(value: "Sweet Stuff", label: "Sweet Stuff"),
        DropdownMenuEntry(value: "Drinks", label: "Drinks")
      ],
      hintText: "Select category",
    );
  }
}

class TitleField extends StatelessWidget {
  const TitleField({
    super.key,
    required Map<String, TextEditingController> allTextFormCtrl,
    required Map<String, dynamic> userInputValues,
  })  : _allTextFormCtrl = allTextFormCtrl,
        _userInputValues = userInputValues;

  final Map<String, TextEditingController> _allTextFormCtrl;
  final Map<String, dynamic> _userInputValues;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _allTextFormCtrl["titleCtrl"],
      onChanged: (value) => _userInputValues["title"] = value,
      decoration: const InputDecoration(
        hintText: "Title",
        border: OutlineInputBorder(),
      ),
    );
  }
}
