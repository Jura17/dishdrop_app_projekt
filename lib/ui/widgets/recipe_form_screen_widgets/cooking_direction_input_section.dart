import 'package:dishdrop_app_projekt/data/provider/recipe_form_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CookingDirectionInputSection extends StatelessWidget {
  const CookingDirectionInputSection({super.key});

  @override
  Widget build(BuildContext context) {
    final recipeFormProvider = context.watch<RecipeFormNotifier>();

    return Row(
      children: [
        Expanded(
          child: TextFormField(
            maxLength: 200,
            maxLines: null,
            controller: recipeFormProvider.allTextControllers["directionDescCtrl"],
            decoration: const InputDecoration(
              counterText: "",
              border: OutlineInputBorder(),
              hintText: "Add cooking directions",
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            recipeFormProvider.addCookingDirectionToList();
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
