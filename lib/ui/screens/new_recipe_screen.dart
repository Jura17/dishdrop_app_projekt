import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:dishdrop_app_projekt/data/models/list_item.dart';
import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/repositories/mock_database.dart';
import 'package:flutter/material.dart';

class NewRecipeScreen extends StatefulWidget {
  NewRecipeScreen({super.key, required this.db});
  MockDatabase db;

  @override
  State<NewRecipeScreen> createState() => _NewRecipeScreenState();
}

class _NewRecipeScreenState extends State<NewRecipeScreen> {
  final TextEditingController _ingredientAmountCtrl = TextEditingController();
  final TextEditingController _ingredientUnitCtrl = TextEditingController();
  final TextEditingController _ingredientDescriptionCtrl =
      TextEditingController();
  final TextEditingController _directionDescriptionCtrl =
      TextEditingController();
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
    "prepTime": "",
    "cookTime": "",
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
                TextFormField(
                  onChanged: (value) => _userInputValues["title"] = value,
                  decoration: const InputDecoration(
                    hintText: "Title",
                    border: OutlineInputBorder(),
                  ),
                ),
                DropdownMenu(
                  onSelected: (value) => _userInputValues["category"] = value,
                  inputDecorationTheme: InputDecorationTheme(
                    border: OutlineInputBorder(),
                  ),
                  width: double.infinity,
                  dropdownMenuEntries: [
                    DropdownMenuEntry(value: "Appetizers", label: "Appetizers"),
                    DropdownMenuEntry(
                        value: "Main Courses", label: "Main Courses"),
                    DropdownMenuEntry(
                        value: "Side Dishes", label: "Side Dishes"),
                    DropdownMenuEntry(value: "Salads", label: "Salads"),
                    DropdownMenuEntry(
                        value: "Sweet Stuff", label: "Sweet Stuff"),
                    DropdownMenuEntry(value: "Drinks", label: "Drinks")
                  ],
                  hintText: "Select category",
                ),
                GestureDetector(
                  onTap: () {},
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      Container(
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
                      SizedBox(height: 30),
                      TextFormField(
                        onChanged: (value) =>
                            _userInputValues["images"]["titleImg"] = value,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: AppColors.lightGrey,
                          hintText: "Image-URL",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                DropdownMenu(
                  onSelected: (value) => _userInputValues["difficulty"] = value,
                  inputDecorationTheme: InputDecorationTheme(
                    border: OutlineInputBorder(),
                  ),
                  width: double.infinity,
                  dropdownMenuEntries: [
                    DropdownMenuEntry(value: "Simple", label: "Simple"),
                    DropdownMenuEntry(
                        value: "Not Too Tricky", label: "Not Too Tricky"),
                    DropdownMenuEntry(value: "Impressive", label: "Impressive"),
                  ],
                  hintText: "Select difficulty",
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Tags",
                    border: OutlineInputBorder(),
                  ),
                ),
                TextFormField(
                  onChanged: (value) => _userInputValues["description"] = value,
                  decoration: const InputDecoration(
                    hintText: "Description",
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 50, horizontal: 16),
                  ),
                ),
                Row(
                  spacing: 10,
                  children: [
                    Expanded(
                      child: TextFormField(
                        onChanged: (value) =>
                            _userInputValues["prepTime"] = int.tryParse(value),
                        decoration: const InputDecoration(
                            filled: true,
                            fillColor: AppColors.lightGrey,
                            border: OutlineInputBorder(),
                            hintText: "Prep Time"),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        onChanged: (value) =>
                            _userInputValues["cookTime"] = int.tryParse(value),
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Cook Time"),
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  onChanged: (value) => _userInputValues["notes"] = value,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Notes",
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 50, horizontal: 16),
                  ),
                ),
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
                        controller: _directionDescriptionCtrl,
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
                              _directionDescriptionCtrl.clear();
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
                            controller: _ingredientDescriptionCtrl,
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
                                  controller: _ingredientAmountCtrl,
                                  onChanged: (value) => _ingredientAmount =
                                      double.tryParse(value),
                                  decoration: const InputDecoration(
                                      filled: true,
                                      fillColor: AppColors.lightGrey,
                                      border: OutlineInputBorder(),
                                      hintText: "Amount"),
                                ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: _ingredientUnitCtrl,
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
                            _ingredientAmountCtrl.clear();
                            _ingredientUnitCtrl.clear();
                            _ingredientDescriptionCtrl.clear();
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
                  spacing: 10,
                  children: [
                    FilledButton(
                      onPressed: () {
                        Recipe newRecipe = Recipe(
                          title: _userInputValues["title"],
                          category: _userInputValues["category"],
                          description: _userInputValues["description"],
                          difficulty: _userInputValues["difficulty"],
                          tags: _userInputValues["tags"],
                          images: _userInputValues["images"],
                          prepTime: _userInputValues["prepTime"],
                          cookTime: _userInputValues["cookTime"],
                          directions: _userInputValues["directions"],
                          ingredients: _userInputValues["ingredients"],
                        );

                        widget.db.addRecipe(newRecipe);
                      },
                      child: Text("Save recipe"),
                    ),
                    FilledButton(
                      onPressed: () {},
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
}
