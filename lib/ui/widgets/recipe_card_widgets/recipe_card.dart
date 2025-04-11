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
      // vorher: /Users/julianrakow/Library/Developer/CoreSimulator/Devices/C31F3B0E-714B-48A8-AF90-9F6AAE590B16/data/Containers/Data/Application/ED25443E-779F-4180-89E8-152F749D7A86/Documents/image_picker_241A95FB-6504-4885-9C5F-69C6229D69B3-32302-00000AFC66C5EA95.jpg
      //nachher: /Users/julianrakow/Library/Developer/CoreSimulator/Devices/C31F3B0E-714B-48A8-AF90-9F6AAE590B16/data/Containers/Data/Application/ED25443E-779F-4180-89E8-152F749D7A86/Documents/image_picker_241A95FB-6504-4885-9C5F-69C6229D69B3-32302-00000AFC66C5EA95.jpg
      print("nachher: ${images["titleImg"]}");

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
