import 'package:dishdrop_app_projekt/data/provider/recipe_form_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotesTextFormField extends StatelessWidget {
  const NotesTextFormField({super.key});

  @override
  Widget build(BuildContext context) {
    final recipeFormProvider = context.watch<RecipeFormNotifier>();

    return TextFormField(
      maxLines: null,
      maxLength: 1000,
      validator: (value) {
        if ((value?.length ?? 0) > 1000) {
          return "Notes are limited to 1000 characters.";
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: recipeFormProvider.allTextControllers["notesCtrl"],
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Notes",
        contentPadding: EdgeInsets.symmetric(vertical: 50, horizontal: 16),
      ),
    );
  }
}
