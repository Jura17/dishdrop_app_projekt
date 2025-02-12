import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/recipe_controller.dart';
import 'package:flutter/material.dart';

class FooterButtonSection extends StatefulWidget {
  const FooterButtonSection({
    super.key,
    required this.recipeController,
    required this.recipe,
    required this.updateCounterTimesCooked,
    required this.showBanner,
  });

  final RecipeController recipeController;
  final Recipe recipe;
  final Function updateCounterTimesCooked;
  final Function showBanner;

  @override
  State<FooterButtonSection> createState() => _FooterButtonSectionState();
}

class _FooterButtonSectionState extends State<FooterButtonSection> {
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
          style: TextButton.styleFrom(
              foregroundColor: Colors.red, iconColor: Colors.red),
          onPressed: () {
            widget.showBanner();
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
