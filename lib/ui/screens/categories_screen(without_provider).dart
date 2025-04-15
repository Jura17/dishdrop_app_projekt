// import 'package:dishdrop_app_projekt/data/models/recipe.dart';
// import 'package:dishdrop_app_projekt/data/recipe_controller.dart';

// import 'package:dishdrop_app_projekt/data/shopping_list_controller.dart';
// import 'package:dishdrop_app_projekt/gen/assets.gen.dart';

// import 'package:dishdrop_app_projekt/ui/screens/recipe_form_screen.dart';

// import 'package:dishdrop_app_projekt/ui/widgets/category_card.dart';
// import 'package:dishdrop_app_projekt/ui/widgets/custom_filled_icon_button.dart';

// import 'package:flutter/material.dart';

// class CategoriesScreen extends StatefulWidget {
//   const CategoriesScreen({
//     super.key,
//     required this.recipeController,
//     required this.shoppingListController,
//   });

//   final RecipeController recipeController;
//   final ShoppingListController shoppingListController;

//   @override
//   State<CategoriesScreen> createState() => _CategoriesScreenState();
// }

// class _CategoriesScreenState extends State<CategoriesScreen> {
//   List<Recipe> allRecipes = [];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text("Categories", style: Theme.of(context).textTheme.headlineLarge),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Center(
//           child: StreamBuilder(
//             stream: widget.recipeController.getAllRecipes(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return CircularProgressIndicator();
//               } else if (snapshot.hasError) {
//                 return Text("Error while collecting data: ${snapshot.error}");
//               } else if (!snapshot.hasData || snapshot.data == null) {
//                 return Text("There was no data to fetch: ${snapshot.error}");
//               }
//               allRecipes = snapshot.data!;
//               return GridView.count(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 16,
//                 mainAxisSpacing: 16,
//                 children: [
//                   CategoryCard(
//                     categoryImg: Assets.images.appetizersCategoryImg.path,
//                     categoryTitle: "Appetizers",
//                     recipeController: widget.recipeController,
//                     shoppingListController: widget.shoppingListController,
//                     allRecipes: allRecipes,
//                   ),
//                   CategoryCard(
//                     categoryImg: Assets.images.mainCoursesCategoryImg.path,
//                     categoryTitle: "Main Courses",
//                     recipeController: widget.recipeController,
//                     shoppingListController: widget.shoppingListController,
//                     allRecipes: allRecipes,
//                   ),
//                   CategoryCard(
//                     categoryImg: Assets.images.sideDishesCategoryImg.path,
//                     categoryTitle: "Side Dishes",
//                     recipeController: widget.recipeController,
//                     shoppingListController: widget.shoppingListController,
//                     allRecipes: allRecipes,
//                   ),
//                   CategoryCard(
//                     categoryImg: Assets.images.salatCategoryImg.path,
//                     categoryTitle: "Salads",
//                     recipeController: widget.recipeController,
//                     shoppingListController: widget.shoppingListController,
//                     allRecipes: allRecipes,
//                   ),
//                   CategoryCard(
//                     categoryImg: Assets.images.sweetStuffCategoryImg.path,
//                     categoryTitle: "Sweet Stuff",
//                     recipeController: widget.recipeController,
//                     shoppingListController: widget.shoppingListController,
//                     allRecipes: allRecipes,
//                   ),
//                   CategoryCard(
//                     categoryImg: Assets.images.drinksCategoryImg.path,
//                     categoryTitle: "Drinks",
//                     recipeController: widget.recipeController,
//                     shoppingListController: widget.shoppingListController,
//                     allRecipes: allRecipes,
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//       floatingActionButton: CustomFilledIconButton(
//         text: "Add Recipe",
//         iconData: Icons.add_box_outlined,
//         recipeController: widget.recipeController,
//         shoppingListController: widget.shoppingListController,
//         newScreen: RecipeFormScreen(
//           recipeController: widget.recipeController,
//           shoppingListController: widget.shoppingListController,
//           allRecipes: allRecipes,
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//     );
//   }
// }
