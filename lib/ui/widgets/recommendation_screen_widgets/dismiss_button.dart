import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';

import 'package:flutter/material.dart';

class DismissButton extends StatelessWidget {
  const DismissButton({
    super.key,
    this.top,
    this.left,
    this.bottom,
    this.right,
    required this.width,
    required this.height,
  });

  final double? top;
  final double? right;
  final double? bottom;
  final double? left;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.white.withAlpha((0.8 * 255).toInt()),
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.lightGrey),
          ),
          child: Icon(
            color: AppColors.dishDropBlack,
            Icons.close,
            size: width * 0.625,
          ),
        ),
      ),
    );
  }
}
