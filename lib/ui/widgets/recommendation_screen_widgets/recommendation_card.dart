import 'package:dishdrop_app_projekt/data/models/recipe.dart';

import 'package:dishdrop_app_projekt/ui/widgets/recommendation_screen_widgets/recommendation_card_image_section.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recommendation_screen_widgets/recommendation_card_info_section.dart';

import 'package:flutter/material.dart';

class RecommendationCard extends StatelessWidget {
  const RecommendationCard({
    super.key,
    required this.recipe,
  });

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              RecommendationCardImageSection(recipe: recipe),
              RecommendationCardInfoSection(recipe: recipe),
            ],
          ),
        ),
      ),
    );
  }
}
