import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:dishdrop_app_projekt/data/models/shopping_list.dart';
import 'package:dishdrop_app_projekt/ui/widgets/file_title_img.dart';

import 'package:flutter/material.dart';

class RecipeShoppingListTitleImage extends StatelessWidget {
  const RecipeShoppingListTitleImage({
    super.key,
    required this.recipeShoppingList,
  });

  final ShoppingList recipeShoppingList;

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;
    String imgPath = recipeShoppingList.imgUrl;

    if (imgPath.contains("assets/images/")) {
      imageWidget = Image.asset(imgPath, fit: BoxFit.cover);
    } else {
      imageWidget = FileTitleImg(imgPath: imgPath);
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.dishDropBlack),
        borderRadius: BorderRadius.circular(20),
      ),
      height: 250,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: imageWidget,
      ),
    );
  }
}
