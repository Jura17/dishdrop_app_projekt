import 'package:dishdrop_app_projekt/core/utils/show_custom_alert_banner.dart';
import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/provider/recipe_notifier.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipeDetailsFooterButtonSection extends StatefulWidget {
  const RecipeDetailsFooterButtonSection({
    super.key,
    required this.recipe,
  });

  final Recipe recipe;

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
            widget.recipe.updateCounterTimesCooked();
            context.read<RecipeNotifier>().updateRecipe(widget.recipe);
            // widget.updateCounterTimesCooked();
          },
          label: Text("I'm done cooking!"),
        ),
        TextButton.icon(
          style: TextButton.styleFrom(foregroundColor: Colors.red, iconColor: Colors.red),
          onPressed: () {
            context.read<RecipeNotifier>().removeRecipe(widget.recipe);
            showCustomAlertBanner(context, Colors.red, "Recipe removed from cookbook.");
            if (mounted) Navigator.of(context).pop();
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
