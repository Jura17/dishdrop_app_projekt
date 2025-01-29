import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:dishdrop_app_projekt/gen/assets.gen.dart';
import 'package:dishdrop_app_projekt/ui/widgets/category.dart';
import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  const Categories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Categories",
            style: Theme.of(context).textTheme.headlineLarge),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              Category(
                categoryImg: Assets.images.appetizersCategoryImg.path,
                categoryTitle: "Appetizers",
              ),
              Category(
                categoryImg: Assets.images.mainCoursesCategoryImg.path,
                categoryTitle: "Main Courses",
              ),
              Category(
                categoryImg: Assets.images.sideDishesCategoryImg.path,
                categoryTitle: "Side Dishes",
              ),
              Category(
                categoryImg: Assets.images.salatCategoryImg.path,
                categoryTitle: "Salats",
              ),
              Category(
                categoryImg: Assets.images.sweetStuffCategoryImg.path,
                categoryTitle: "Sweet Stuff",
              ),
              Category(
                categoryImg: Assets.images.drinksCategoryImg.path,
                categoryTitle: "Drinks",
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.primary,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_rounded, size: 40), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.lightbulb_outline, size: 40), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.sticky_note_2_outlined, size: 40), label: ""),
        ],
      ),
    );
  }
}
