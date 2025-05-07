import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:dishdrop_app_projekt/data/provider/recipe_form_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IngredientInputSection extends StatelessWidget {
  const IngredientInputSection({super.key});

  @override
  Widget build(BuildContext context) {
    final recipeFormProvider = context.watch<RecipeFormNotifier>();

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              TextFormField(
                maxLength: 40,
                controller: recipeFormProvider.allTextControllers["ingredientDescCtrl"],
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Ingredient description",
                  counterText: "",
                ),
              ),
              Row(
                spacing: 10,
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      validator: (value) {
                        if (value == '') return null;
                        double? amount = double.tryParse(value ?? '');
                        if (amount == null) return "Only numerics allowed";
                        if (amount < 0) return "Only positives allowed";
                        return null;
                      },
                      maxLength: 6,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: recipeFormProvider.allTextControllers["ingredientAmountCtrl"],
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: AppColors.lightGrey,
                        border: OutlineInputBorder(),
                        hintText: "Amount",
                        counterText: "",
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      maxLength: 10,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: recipeFormProvider.allTextControllers["ingredientUnitCtrl"],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Unit",
                        counterText: "",
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                "You can enter fractional amounts like 1½ as 1.5",
                style: Theme.of(context).textTheme.labelMedium?.copyWith(fontStyle: FontStyle.italic),
              )
            ],
          ),
        ),
        IconButton(
          onPressed: () {
            recipeFormProvider.addIngredientToList();
          },
          icon: Icon(
            Icons.add_box_outlined,
            size: 50,
          ),
        )
      ],
    );
  }
}
