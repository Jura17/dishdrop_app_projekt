import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  const LikeButton(
      {super.key,
      required this.top,
      required this.right,
      required this.width,
      required this.height,
      // required this.iconSize,
      required this.recipe});

  final double top;
  final double right;
  final double width;
  final double height;
  // final double iconSize;
  final Recipe recipe;

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.top,
      right: widget.top,
      child: GestureDetector(
        onTap: () {
          setState(() {
            widget.recipe.isFavorite = !widget.recipe.isFavorite;
          });
        },
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: Colors.white.withAlpha((0.8 * 255).toInt()),
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.lightGrey),
          ),
          child: Icon(
            widget.recipe.isFavorite
                ? Icons.favorite
                : Icons.favorite_border_outlined,
            color: Theme.of(context).primaryColor,
            size: widget.width * 0.625,
          ),
        ),
      ),
    );
  }
}
