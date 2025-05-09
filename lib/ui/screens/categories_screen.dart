import 'package:dishdrop_app_projekt/data/provider/recipe_form_notifier.dart';
import 'package:dishdrop_app_projekt/gen/assets.gen.dart';
import 'package:dishdrop_app_projekt/ui/screens/recipe_form_screen.dart';

import 'package:dishdrop_app_projekt/ui/widgets/category_card.dart';
import 'package:dishdrop_app_projekt/ui/widgets/custom_filled_icon_button.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({
    super.key,
  });

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Categories", style: Theme.of(context).textTheme.headlineLarge),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              CategoryCard(
                categoryImg: Assets.images.appetizersCategoryImg.path,
                categoryTitle: "Appetizers",
              ),
              CategoryCard(
                categoryImg: Assets.images.mainCoursesCategoryImg.path,
                categoryTitle: "Main Courses",
              ),
              CategoryCard(
                categoryImg: Assets.images.sideDishesCategoryImg.path,
                categoryTitle: "Side Dishes",
              ),
              CategoryCard(
                categoryImg: Assets.images.salatCategoryImg.path,
                categoryTitle: "Salads",
              ),
              CategoryCard(
                categoryImg: Assets.images.sweetStuffCategoryImg.path,
                categoryTitle: "Sweet Stuff",
              ),
              CategoryCard(
                categoryImg: Assets.images.drinksCategoryImg.path,
                categoryTitle: "Drinks",
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: CustomFilledIconButton(
        text: "Add Recipe",
        iconData: Icons.add_box_outlined,
        newScreen: ChangeNotifierProvider(
          create: (_) {
            final RecipeFormNotifier recipeFormNotifier = RecipeFormNotifier();
            recipeFormNotifier.init();
            return recipeFormNotifier;
          },
          child: RecipeFormScreen(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
