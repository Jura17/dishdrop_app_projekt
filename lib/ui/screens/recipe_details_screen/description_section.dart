import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:flutter/material.dart';

class DescriptionSection extends StatelessWidget {
  const DescriptionSection({super.key, required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Description", style: Theme.of(context).textTheme.headlineMedium),
        Text(
          recipe.description,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
