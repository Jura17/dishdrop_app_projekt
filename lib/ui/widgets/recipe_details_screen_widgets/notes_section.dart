import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:flutter/material.dart';

class NotesSection extends StatelessWidget {
  const NotesSection({super.key, required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Notes", style: Theme.of(context).textTheme.headlineMedium),
        Text(
          recipe.notes,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
