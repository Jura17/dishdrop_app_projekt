import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:flutter/material.dart';

class DirectionsSection extends StatelessWidget {
  const DirectionsSection({super.key, required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Directions", style: Theme.of(context).textTheme.headlineMedium),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            recipe.directions.length,
            (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${index + 1}. ",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Expanded(
                      child: Text(
                        recipe.directions[index].description,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
