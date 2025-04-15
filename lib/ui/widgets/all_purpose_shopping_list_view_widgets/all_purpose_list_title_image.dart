import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:dishdrop_app_projekt/data/models/shopping_list.dart';

import 'package:dishdrop_app_projekt/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class AllPurposeListTitleImage extends StatelessWidget {
  const AllPurposeListTitleImage({
    required this.allPurposeShoppingList,
    super.key,
  });

  final ShoppingList allPurposeShoppingList;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.dishDropBlack),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          allPurposeShoppingList.imgUrl,
          height: 250,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
