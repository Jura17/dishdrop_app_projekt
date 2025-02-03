import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:flutter/material.dart';

class TagsSection extends StatelessWidget {
  const TagsSection({super.key, required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    String tagString = "";
    for (int i = 0; i < recipe.tags.length; i++) {
      tagString = tagString + recipe.tags[i];
      if (i < recipe.tags.length) tagString = "$tagString, ";
    }

    return Column(
      children: [
        RichText(
          text: TextSpan(
            text: "Tags: ",
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                text: tagString,
                style: Theme.of(context).textTheme.bodyLarge,
              )
            ],
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
