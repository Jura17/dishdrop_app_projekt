import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:dishdrop_app_projekt/ui/widgets/file_title_img.dart';
import 'package:dishdrop_app_projekt/ui/widgets/network_title_img.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_shopping_list_view_widgets/recipe_shopping_list_view.dart';
import 'package:flutter/material.dart';

class RecipeShoppingListTitleImage extends StatelessWidget {
  const RecipeShoppingListTitleImage({
    super.key,
    required this.widget,
  });

  final RecipeShoppingListIngredientListView widget;

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;
    String imgPath = widget.recipeShoppingList.imgUrl;

    if (imgPath.contains("http")) {
      imageWidget = NetworkTitleImg(imgPath: imgPath);
    } else if (imgPath.contains("assets/images/")) {
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
        // TODO: app crashes in offline-mode because loading images fails
        // child: Image.asset(
        //   widget.recipeShoppingList.imgUrl,
        //   height: 250,
        //   width: double.infinity,
        //   fit: BoxFit.cover,
        // ),
        child: imageWidget,
      ),
    );
  }
}
