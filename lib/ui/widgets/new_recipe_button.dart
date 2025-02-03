import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:dishdrop_app_projekt/ui/screens/new_recipe_screen.dart';
import 'package:flutter/material.dart';

class FilledIconButton extends StatelessWidget {
  const FilledIconButton({
    super.key,
    required this.text,
    required this.iconData,
  });

  final String text;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      style: FilledButton.styleFrom(backgroundColor: AppColors.lightGreen),
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => NewRecipeScreen()));
      },
      label: Text(
        text,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: AppColors.primary,
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
