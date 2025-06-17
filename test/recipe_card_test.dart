import 'dart:convert';

import 'package:dishdrop_app_projekt/data/models/recipe.dart';

import 'package:dishdrop_app_projekt/data/provider/recipe_notifier.dart';
import 'package:dishdrop_app_projekt/data/provider/shopping_list_notifier.dart';
import 'package:dishdrop_app_projekt/data/repositories/database_repository.dart';
import 'package:dishdrop_app_projekt/data/repositories/mock_database.dart';
import 'package:dishdrop_app_projekt/ui/screens/recipe_details_screen.dart';

import 'package:dishdrop_app_projekt/ui/widgets/like_button.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_card_widgets/recipe_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() async {
  group('RecipeCard widget tests', () {
    testWidgets(
      'renders image and info correctly',
      (WidgetTester tester) async {
        final testRecipe = Recipe(
          id: 1,
          title: "Test Recipe",
          category: "Main Courses",
          description: "",
          notes: "",
          difficulty: "Simple",
          imagesJson: jsonEncode({"titleImg": "assets/images/placeholder_recipe_img.jpg"}),
          tags: [],
          prepTime: 20,
          cookingTime: 15,
          lastUpdated: DateTime.now(),
        );

        final DatabaseRepository mockDB = MockDatabase();
        final mockRecipeNotifier = RecipeNotifier(mockDB);
        mockRecipeNotifier.addRecipe(testRecipe);

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: ChangeNotifierProvider<RecipeNotifier>.value(
                  value: mockRecipeNotifier,
                  child: RecipeCard(recipeId: 1),
                ),
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.byType(Image), findsOneWidget);
        expect(find.byType(LikeButton), findsOneWidget);
        expect(find.text('Test Recipe'), findsOneWidget);
        expect(find.text('Another Recipe'), findsNothing);
      },
    );
    testWidgets(
      'Tapping a RecipeCard opens RecipeDetailsScreen with correct content',
      (WidgetTester tester) async {
        final testRecipe = Recipe(
          id: 1,
          title: "Test Recipe",
          category: "Main Courses",
          description: "",
          notes: "",
          difficulty: "Simple",
          imagesJson: jsonEncode({"titleImg": "assets/images/placeholder_recipe_img.jpg"}),
          tags: [],
          prepTime: 20,
          cookingTime: 15,
          lastUpdated: DateTime.now(),
        );

        final DatabaseRepository mockDB = MockDatabase();
        final mockRecipeNotifier = RecipeNotifier(mockDB);
        final mockShoppingListNotifier = ShoppingListNotifier(mockDB);
        mockRecipeNotifier.addRecipe(testRecipe);

        await tester.pumpWidget(
          MultiProvider(
            providers: [
              ChangeNotifierProvider<RecipeNotifier>.value(value: mockRecipeNotifier),
              ChangeNotifierProvider<ShoppingListNotifier>.value(value: mockShoppingListNotifier),
            ],
            child: MaterialApp(
              home: Scaffold(
                body: Center(
                  child: RecipeCard(recipeId: 1),
                ),
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.text('Test Recipe'), findsOneWidget);

        await tester.tap(find.text('Test Recipe'));
        await tester.pumpAndSettle();

        expect(find.byType(RecipeDetailsScreen), findsOneWidget);
        expect(find.text('Test Recipe'), findsWidgets);
      },
    );
  });
}
