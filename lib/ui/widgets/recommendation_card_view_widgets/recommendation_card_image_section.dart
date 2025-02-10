import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/ui/widgets/dismiss_button.dart';
import 'package:dishdrop_app_projekt/ui/widgets/like_button.dart';
import 'package:flutter/material.dart';

class RecommendationCardImageSection extends StatelessWidget {
  const RecommendationCardImageSection({
    super.key,
    required this.recipe,
  });

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.network(
              errorBuilder: (context, error, stackTrace) => Center(
                child: Text(
                  "404",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              recipe.images["titleImg"],
              fit: BoxFit.cover,
            ),
          ),
          LikeButton(
            top: 20,
            right: 20,
            width: 60,
            height: 60,
            recipe: recipe,
          ),
          DismissButton(
            top: 20,
            left: 20,
            width: 40,
            height: 40,
          ),
        ],
      ),
    );
  }
}
