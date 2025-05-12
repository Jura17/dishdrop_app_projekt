import 'dart:convert';

import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:dishdrop_app_projekt/data/models/recipe.dart';

import 'package:dishdrop_app_projekt/ui/widgets/file_title_img.dart';
import 'package:dishdrop_app_projekt/ui/widgets/like_button.dart';

import 'package:flutter/material.dart';

class RecipeDetailsTitleImage extends StatelessWidget {
  const RecipeDetailsTitleImage({
    super.key,
    required this.recipe,
  });

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;
    Map<String, dynamic> images = jsonDecode(recipe.imagesJson);

    if (recipe.images["titleImg"].contains("assets/images/")) {
      imageWidget = Image.asset(images["titleImg"], fit: BoxFit.cover);
    } else {
      imageWidget = FileTitleImg(imgPath: images["titleImg"]);
    }

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.dishDropBlack),
          ),
          height: 300,
          width: double.infinity,
          child: ClipRRect(borderRadius: BorderRadius.circular(20), child: imageWidget),
        ),
        LikeButton(
          top: 20,
          right: 20,
          width: 60,
          height: 60,
          recipe: recipe,
        )
      ],
    );
  }
}
