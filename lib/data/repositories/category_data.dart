import 'package:dishdrop_app_projekt/gen/assets.gen.dart';
import 'package:dishdrop_app_projekt/ui/widgets/category.dart';

final List<Category> allCategories = [
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
];
