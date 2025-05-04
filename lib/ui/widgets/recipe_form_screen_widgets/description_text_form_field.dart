import 'package:dishdrop_app_projekt/data/provider/recipe_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DescriptionTextFormField extends StatelessWidget {
  const DescriptionTextFormField({super.key});

  @override
  Widget build(BuildContext context) {
    final recipeFormProvider = context.watch<RecipeFormProvider>();

    return TextFormField(
      maxLines: null,
      maxLength: 1000,
      validator: (value) {
        if ((value?.length ?? 0) > 1000) {
          return "The description is limited to 1000 characters.";
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: recipeFormProvider.allTextControllers["descCtrl"],
      decoration: const InputDecoration(
        hintText: "Description",
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      ),
    );
  }
}
