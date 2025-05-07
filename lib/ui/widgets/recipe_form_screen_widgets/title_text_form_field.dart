import 'package:dishdrop_app_projekt/data/provider/recipe_form_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TitleTextFormField extends StatelessWidget {
  const TitleTextFormField({super.key});

  @override
  Widget build(BuildContext context) {
    final recipeFormProvider = context.read<RecipeFormNotifier>();
    return TextFormField(
      validator: (value) {
        String? title = value ?? '';
        if (title == '') {
          return "Please enter a title for your recipe.";
        }

        return null;
      },
      autovalidateMode: AutovalidateMode.onUnfocus,
      controller: recipeFormProvider.allTextControllers["titleCtrl"],
      decoration: const InputDecoration(
        hintText: "Title",
        border: OutlineInputBorder(),
      ),
    );
  }
}
