import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/models/shopping_list.dart';
import 'package:dishdrop_app_projekt/data/repositories/mock_database.dart';
import 'package:dishdrop_app_projekt/ui/widgets/ingredient_list_view.dart';
import 'package:dishdrop_app_projekt/ui/widgets/servings_picker.dart';
import 'package:flutter/material.dart';

class IngredientsSection extends StatelessWidget {
  const IngredientsSection({super.key, required this.recipe, required this.db});

  final Recipe recipe;
  final MockDatabase db;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Ingredients", style: Theme.of(context).textTheme.headlineMedium),
        SizedBox(height: 15),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ServingsPicker(),
            FilledButton(
              onPressed: () {
                db.addShoppingList(ShoppingList(
                    title: recipe.title, shoppingItems: recipe.ingredients));
              },
              style: Theme.of(context).filledButtonTheme.style,
              child: Text("Add to shoppings list"),
            ),
          ],
        ),
        SizedBox(height: 15),
        IngredientListView(recipe: recipe)
      ],
    );
  }
}
