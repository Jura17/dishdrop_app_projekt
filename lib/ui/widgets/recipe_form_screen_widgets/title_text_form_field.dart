import 'package:dishdrop_app_projekt/data/models/recipe.dart';

import 'package:flutter/material.dart';

class TitleTextFormField extends StatelessWidget {
  const TitleTextFormField({super.key, required this.titleCtrl, required this.allRecipes});

  final TextEditingController titleCtrl;
  final List<Recipe> allRecipes;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        String? title = value ?? '';
        if (title == '') {
          return "Please enter a title for your recipe.";
        }

        for (var recipe in allRecipes) {
          if (recipe.title == title) {
            return "You already have a recipe by that title.";
          }
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUnfocus,
      controller: titleCtrl,
      decoration: const InputDecoration(
        hintText: "Title",
        border: OutlineInputBorder(),
      ),
    );
  }
}
