import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SearchResultImage extends StatelessWidget {
  const SearchResultImage({
    super.key,
    required this.imageWidget,
  });

  final Widget imageWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.dishDropBlack),
      ),
      height: 125,
      width: 175,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: imageWidget,
      ),
    );
  }
}
