import 'package:dishdrop_app_projekt/data/repositories/mock_database.dart';
import 'package:dishdrop_app_projekt/gen/assets.gen.dart';

import 'package:dishdrop_app_projekt/ui/widgets/category_card.dart';
import 'package:dishdrop_app_projekt/ui/widgets/filled_icon_button.dart';

import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.db});

  final MockDatabase db;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FilledIconButton(
        text: "Add Recipe",
        iconData: Icons.add_box_outlined,
        db: db,
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text("Categories",
            style: Theme.of(context).textTheme.headlineLarge),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: GridView.count(
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              CategoryCard(
                categoryImg: Assets.images.appetizersCategoryImg.path,
                categoryTitle: "Appetizers",
                db: db,
              ),
              CategoryCard(
                categoryImg: Assets.images.mainCoursesCategoryImg.path,
                categoryTitle: "Main Courses",
                db: db,
              ),
              CategoryCard(
                categoryImg: Assets.images.sideDishesCategoryImg.path,
                categoryTitle: "Side Dishes",
                db: db,
              ),
              CategoryCard(
                categoryImg: Assets.images.salatCategoryImg.path,
                categoryTitle: "Salads",
                db: db,
              ),
              CategoryCard(
                categoryImg: Assets.images.sweetStuffCategoryImg.path,
                categoryTitle: "Sweet Stuff",
                db: db,
              ),
              CategoryCard(
                categoryImg: Assets.images.drinksCategoryImg.path,
                categoryTitle: "Drinks",
                db: db,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
