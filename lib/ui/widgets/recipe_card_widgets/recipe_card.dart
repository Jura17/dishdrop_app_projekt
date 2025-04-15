import 'dart:convert';

import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/recipe_controller.dart';

import 'package:dishdrop_app_projekt/data/shopping_list_controller.dart';
import 'package:dishdrop_app_projekt/ui/screens/recipe_details_screen.dart';
import 'package:dishdrop_app_projekt/ui/widgets/file_title_img.dart';
import 'package:dishdrop_app_projekt/ui/widgets/like_button.dart';
import 'package:dishdrop_app_projekt/ui/widgets/network_title_img.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_card_widgets/recipe_card_info_box.dart';
import 'package:flutter/material.dart';

class RecipeCard extends StatefulWidget {
  const RecipeCard({
    super.key,
    required this.recipe,
    required this.recipeController,
    required this.shoppingListController,
  });

  final Recipe recipe;
  final RecipeController recipeController;
  final ShoppingListController shoppingListController;

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> images = jsonDecode(widget.recipe.imagesJson);
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
              recipe: widget.recipe,
              recipeController: widget.recipeController,
              shoppingListController: widget.shoppingListController,
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
                        recipe: widget.recipe,
                      ),
                    ],
                  ),
                ),
                RecipeCardInfoBox(recipe: widget.recipe)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
