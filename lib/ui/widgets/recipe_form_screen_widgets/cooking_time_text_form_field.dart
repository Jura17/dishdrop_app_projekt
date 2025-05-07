import 'package:dishdrop_app_projekt/data/provider/recipe_form_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CookingTimeTextFormField extends StatelessWidget {
  const CookingTimeTextFormField({super.key});

  @override
  Widget build(BuildContext context) {
    final recipeFormProvider = context.watch<RecipeFormNotifier>();

    return TextFormField(
      validator: (value) {
        int? time = int.tryParse(value ?? '');
        if (time == null) return "Numeric values only";
        if (time < 0) return "Positive values only";
        return null;
      },
      maxLength: 4,
      keyboardType: TextInputType.numberWithOptions(decimal: false),
      autovalidateMode: AutovalidateMode.onUnfocus,
      controller: recipeFormProvider.allTextControllers["cookingTimeCtrl"],
      decoration: const InputDecoration(border: OutlineInputBorder(), hintText: "Cooking Time", counterText: ""),
    );
  }
}
