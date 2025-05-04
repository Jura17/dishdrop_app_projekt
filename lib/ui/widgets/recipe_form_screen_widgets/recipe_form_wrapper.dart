import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/provider/recipe_form_provider.dart';
import 'package:dishdrop_app_projekt/ui/screens/recipe_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipeFormWrapper extends StatelessWidget {
  const RecipeFormWrapper({super.key, this.recipe});

  final Recipe? recipe;

  @override
  Widget build(BuildContext context) {
    // return ChangeNotifierProvider<RecipeFormProvider>(
    //   create: (_) => RecipeFormProvider(recipe: recipe),
    //   child: RecipeFormScreen(),
    // );
    return RecipeFormScreen();
  }
}
