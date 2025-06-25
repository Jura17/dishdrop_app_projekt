import 'package:dishdrop_app_projekt/core/constants/category_routes.dart';
import 'package:dishdrop_app_projekt/dish_drop_app.dart';
import 'package:dishdrop_app_projekt/ui/screens/categories_screen.dart';
import 'package:dishdrop_app_projekt/ui/screens/recipe_details_screen.dart';
import 'package:dishdrop_app_projekt/ui/screens/recipe_form_screen.dart';
import 'package:dishdrop_app_projekt/ui/screens/recipe_grid_view.dart';
import 'package:dishdrop_app_projekt/ui/screens/recommendation_screen.dart';
import 'package:dishdrop_app_projekt/ui/screens/settings_screen.dart';
import 'package:dishdrop_app_projekt/ui/screens/shopping_list_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

final _categoriesNavigatorKey = GlobalKey<NavigatorState>();
final _recommendationNavigatorKey = GlobalKey<NavigatorState>();
final _shoppingListNavigatorKey = GlobalKey<NavigatorState>();
final _settingsNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: '/categories',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => DishDropApp(shell: navigationShell),
      branches: [
        /// ---------- RECIPES ----------
        StatefulShellBranch(
          navigatorKey: _categoriesNavigatorKey,
          routes: [
            GoRoute(
              path: '/categories',
              builder: (context, state) => CategoriesScreen(),
              routes: [
                GoRoute(
                  path: 'recipes/:category',
                  builder: (context, state) {
                    final slug = state.pathParameters['category'];
                    final categoryTitle = categoryTitleRoutes.entries.firstWhere((entry) => entry.value == slug).key;
                    return RecipeGridView(category: categoryTitle);
                  },
                ),
                GoRoute(
                  path: 'recipe-detail/:id',
                  builder: (context, state) {
                    final recipeId = int.parse(state.pathParameters['id']!);
                    return RecipeDetailsScreen(recipeId: recipeId);
                  },
                ),
                GoRoute(
                  path: 'edit-recipe/:id',
                  builder: (context, state) {
                    final recipeId = int.parse(state.pathParameters['id']!);
                    return RecipeFormScreenWrapper(recipeId: recipeId);
                  },
                ),
                GoRoute(
                  path: 'add-recipe',
                  builder: (context, state) => RecipeFormScreenWrapper(),
                ),
              ],
            ),
          ],
        ),

        /// ---------- RECOMMENDATION ----------
        StatefulShellBranch(
          navigatorKey: _recommendationNavigatorKey,
          routes: [
            GoRoute(
              path: '/recommendation',
              builder: (context, state) => const RecommendationScreen(),
              routes: [
                GoRoute(
                  path: 'recipe-detail/:id',
                  builder: (context, state) {
                    final recipeId = int.parse(state.pathParameters['id']!);
                    return RecipeDetailsScreen(recipeId: recipeId);
                  },
                ),
                GoRoute(
                  path: 'edit-recipe/:id',
                  builder: (context, state) {
                    final recipeId = int.parse(state.pathParameters['id']!);
                    return RecipeFormScreenWrapper(recipeId: recipeId);
                  },
                ),
                GoRoute(
                  path: 'add-recipe',
                  builder: (context, state) => RecipeFormScreenWrapper(),
                ),
              ],
            ),
          ],
        ),

        /// ---------- SHOPPING LIST ----------
        StatefulShellBranch(
          navigatorKey: _shoppingListNavigatorKey,
          routes: [
            GoRoute(
              path: '/shopping-list',
              builder: (context, state) => const ShoppingListScreen(),
              routes: [
                GoRoute(
                  path: 'recipe-detail/:id',
                  builder: (context, state) {
                    final recipeId = int.parse(state.pathParameters['id']!);
                    return RecipeDetailsScreen(recipeId: recipeId);
                  },
                ),
                GoRoute(
                  path: 'edit-recipe/:id',
                  builder: (context, state) {
                    final recipeId = int.parse(state.pathParameters['id']!);
                    return RecipeFormScreenWrapper(recipeId: recipeId);
                  },
                ),
                GoRoute(
                  path: 'add-recipe',
                  builder: (context, state) => RecipeFormScreenWrapper(),
                ),
              ],
            ),
          ],
        ),

        /// ---------- SETTINGS ----------
        StatefulShellBranch(
          navigatorKey: _settingsNavigatorKey,
          routes: [
            GoRoute(
              path: '/settings',
              builder: (context, state) => const SettingsScreen(),
              routes: [
                GoRoute(
                  path: 'recipe-detail/:id',
                  builder: (context, state) {
                    final recipeId = int.parse(state.pathParameters['id']!);
                    return RecipeDetailsScreen(recipeId: recipeId);
                  },
                ),
                GoRoute(
                  path: 'edit-recipe/:id',
                  builder: (context, state) {
                    final recipeId = int.parse(state.pathParameters['id']!);
                    return RecipeFormScreenWrapper(recipeId: recipeId);
                  },
                ),
                GoRoute(
                  path: 'add-recipe',
                  builder: (context, state) => RecipeFormScreenWrapper(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
