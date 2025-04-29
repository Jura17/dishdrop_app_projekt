import 'dart:convert';

import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';

import 'package:dishdrop_app_projekt/data/provider/recipe_notifier.dart';

import 'package:dishdrop_app_projekt/ui/screens/recipe_details_screen.dart';
import 'package:dishdrop_app_projekt/ui/widgets/file_title_img.dart';
import 'package:dishdrop_app_projekt/ui/widgets/like_button.dart';
import 'package:dishdrop_app_projekt/ui/widgets/network_title_img.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_card_widgets/recipe_card_info_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipeCard extends StatefulWidget {
  const RecipeCard({
    super.key,
    required this.recipeId,
  });

  final int recipeId;

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  @override
  Widget build(BuildContext context) {
    final recipeNotifier = context.read<RecipeNotifier>();
    final recipe = recipeNotifier.getRecipeById(widget.recipeId);

    Map<String, dynamic> images = jsonDecode(recipe!.imagesJson);
    Widget imageWidget;
    if (images["titleImg"].contains("http")) {
      imageWidget = NetworkTitleImg(imgPath: images["titleImg"]);
    } else if (images["titleImg"].contains("assets/images/")) {
      imageWidget = Image.asset(images["titleImg"]);
    } else {
      imageWidget = FileTitleImg(imgPath: images["titleImg"]);
    }

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => RecipeDetailsScreen(
              recipeId: widget.recipeId,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.dishDropBlack),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: imageWidget,
                      ),
                      LikeButton(
                        top: 10,
                        right: 10,
                        width: 40,
                        height: 40,
                        recipe: recipe,
                      ),
                    ],
                  ),
                ),
                RecipeCardInfoBox(recipe: recipe)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
