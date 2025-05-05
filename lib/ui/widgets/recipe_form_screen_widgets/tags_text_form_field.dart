import 'package:dishdrop_app_projekt/data/provider/recipe_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TagsInputSection extends StatelessWidget {
  const TagsInputSection({super.key});

  @override
  Widget build(BuildContext context) {
    final recipeFormProvider = context.watch<RecipeFormProvider>();

    return Row(
      children: [
        Expanded(
          child: TextFormField(
            maxLength: 30,
            onFieldSubmitted: (value) => recipeFormProvider.addToTagsList(),
            controller: recipeFormProvider.allTextControllers["tagsCtrl"],
            decoration: const InputDecoration(border: OutlineInputBorder(), hintText: "Tags", counterText: ""),
          ),
        ),
        IconButton(
          onPressed: () {
            recipeFormProvider.addToTagsList();
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
