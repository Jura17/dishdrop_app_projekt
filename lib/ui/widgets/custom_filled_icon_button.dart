import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';

import 'package:flutter/material.dart';

class CustomFilledIconButton extends StatelessWidget {
  const CustomFilledIconButton({
    super.key,
    required this.text,
    required this.iconData,
    required this.newScreen,
    this.backgroundColor,
  });

  final String text;
  final IconData iconData;
  final Widget newScreen;
  final Color? backgroundColor;

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
