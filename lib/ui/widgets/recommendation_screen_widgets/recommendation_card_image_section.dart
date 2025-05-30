import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recommendation_screen_widgets/dismiss_button.dart';
import 'package:dishdrop_app_projekt/ui/widgets/file_title_img.dart';
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
    Widget imageWidget;
    if (recipe.images["titleImg"].contains("assets/images/")) {
      imageWidget = Image.asset(
        recipe.images["titleImg"],
        fit: BoxFit.cover,
      );
    } else {
      imageWidget = FileTitleImg(imgPath: recipe.images["titleImg"]);
    }
    return Expanded(
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: imageWidget,
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
