import 'package:dishdrop_app_projekt/data/provider/recipe_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryDropdownMenu extends StatelessWidget {
  const CategoryDropdownMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final recipeFormProvider = context.read<RecipeFormProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownMenu(
          initialSelection: recipeFormProvider.allTextControllers["categoryCtrl"]!.text,
          onSelected: (value) {
            recipeFormProvider.updateCategoryMenuError(false);
          },
          controller: recipeFormProvider.allTextControllers["categoryCtrl"],
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
        ),
        SizedBox(height: 10),
        if (recipeFormProvider.getCategoryErrorState())
          Text(
            "Please select a category",
            style: TextStyle(color: Colors.red),
          ),
        SizedBox(height: 10),
      ],
    );
  }
}
