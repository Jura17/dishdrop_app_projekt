import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/recipe_controller.dart';
import 'package:flutter/material.dart';

class RecipeDetailsFooterButtonSection extends StatefulWidget {
  const RecipeDetailsFooterButtonSection({
    super.key,
    required this.recipe,
    required this.updateCounterTimesCooked,
    required this.removeRecipeFunc,
    required this.toggleLoadingFunc,
  });

  final Recipe recipe;
  final Function updateCounterTimesCooked;
  final Function removeRecipeFunc;
  final Function toggleLoadingFunc;

  @override
  State<RecipeDetailsFooterButtonSection> createState() => _RecipeDetailsFooterButtonSectionState();
}

class _RecipeDetailsFooterButtonSectionState extends State<RecipeDetailsFooterButtonSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 30,
      children: [
        FilledButton.icon(
          icon: Icon(Icons.check),
          onPressed: () {
            widget.updateCounterTimesCooked();
          },
          label: Text("I'm done cooking!"),
        ),
        TextButton.icon(
          style: TextButton.styleFrom(foregroundColor: Colors.red, iconColor: Colors.red),
          onPressed: () async {
            widget.toggleLoadingFunc(true);
            await widget.removeRecipeFunc();
            widget.toggleLoadingFunc(false);
          },
          label: Text("Remove recipe"),
          icon: Icon(
            Icons.delete,
            size: 30,
          ),
        ),
      ],
    );
  }
}
