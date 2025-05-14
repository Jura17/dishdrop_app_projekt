import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:dishdrop_app_projekt/data/provider/recipe_form_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PrepTimeTextFormField extends StatelessWidget {
  const PrepTimeTextFormField({super.key});

  @override
  Widget build(BuildContext context) {
    final recipeFormProvider = context.watch<RecipeFormNotifier>();

    return TextFormField(
      validator: (value) {
        int? time = int.tryParse(value ?? '');
        // if (time == null) return "Numeric values only";
        if (time != null && time < 0) return "Positives values only";
        return null;
      },
      maxLength: 4,
      autovalidateMode: AutovalidateMode.onUnfocus,
      keyboardType: TextInputType.numberWithOptions(decimal: false),
      controller: recipeFormProvider.allTextControllers["prepTimeCtrl"],
      decoration: const InputDecoration(
          filled: true,
          fillColor: AppColors.lightGrey,
          border: OutlineInputBorder(),
          hintText: "Prep Time",
          counterText: ""),
    );
  }
}
