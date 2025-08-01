import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:dishdrop_app_projekt/core/constants/category_routes.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.categoryImg,
    required this.categoryTitle,
  });

  final String categoryTitle;
  final String categoryImg;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final routeSlug = categoryTitleRoutes[categoryTitle];
        if (routeSlug != null) {
          context.push('/categories/recipes/$routeSlug');
        } else {
          debugPrint('Unknown category title: $categoryTitle');
        }
      },
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.dishDropBlack),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          image: DecorationImage(
            image: AssetImage(categoryImg),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                gradient: LinearGradient(
                    begin: Alignment.center, end: Alignment.bottomCenter, colors: [Color(0x00000000), Colors.black]),
              ),
              width: double.infinity,
              height: double.infinity,
            ),
            Column(
              children: [
                Spacer(),
                Text(
                  categoryTitle,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white),
                ),
                SizedBox(height: 16)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
