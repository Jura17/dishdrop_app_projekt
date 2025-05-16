import 'package:dishdrop_app_projekt/data/provider/recipe_form_notifier.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DifficultyDropdownMenu extends StatelessWidget {
  const DifficultyDropdownMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final recipeFormProvider = context.watch<RecipeFormNotifier>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownMenu(
          initialSelection: recipeFormProvider.allTextControllers["difficultyCtrl"]!.text,
          onSelected: (value) {
            recipeFormProvider.updateDifficultyMenuError(false);
          },
          controller: recipeFormProvider.allTextControllers["difficultyCtrl"],
          width: double.infinity,
          dropdownMenuEntries: [
            DropdownMenuEntry(value: "Simple", label: "Simple"),
            DropdownMenuEntry(value: "Not Too Tricky", label: "Not Too Tricky"),
            DropdownMenuEntry(value: "Impressive", label: "Impressive"),
          ],
          hintText: "Select difficulty",
        ),
        SizedBox(height: 10),
        if (recipeFormProvider.getDifficultyErrorState())
          Text(
            "Please select a difficulty",
            style: TextStyle(color: Colors.red),
          ),
        SizedBox(height: 10),
      ],
    );
  }
}
