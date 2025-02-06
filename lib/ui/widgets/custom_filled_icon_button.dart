import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:dishdrop_app_projekt/data/recipe_controller.dart';
import 'package:dishdrop_app_projekt/data/shopping_list_controller.dart';

import 'package:flutter/material.dart';

class CustomFilledIconButton extends StatelessWidget {
  const CustomFilledIconButton(
      {super.key,
      required this.text,
      required this.iconData,
      this.backgroundColor,
      this.recipeController,
      this.shoppingListController,
      required this.newScreen});

  final String text;
  final IconData iconData;
  final Color? backgroundColor;
  final RecipeController? recipeController;
  final ShoppingListController? shoppingListController;
  final Widget newScreen;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      style: FilledButton.styleFrom(backgroundColor: AppColors.lightGreen),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => newScreen),
        );
      },
      label: Text(
        text,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: backgroundColor ?? AppColors.primary,
            ),
      ),
      icon: Icon(
        iconData,
        color: AppColors.primary,
        size: 28,
      ),
    );
  }
}
