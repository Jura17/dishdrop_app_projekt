import 'package:dishdrop_app_projekt/gen/assets.gen.dart';

import '../models/recipe.dart';
import '../models/shopping_list.dart';
import 'database_repository.dart';

class MockDatabase implements DatabaseRepository {
  final List<Recipe> _recipeData = [
    Recipe(
      title: "Sesame Chicken",
      category: "Main Courses",
      difficulty: "Not too tricky",
      images: {
        "titleImg": Assets.images.mainCoursesCategoryImg.path,
        "cookingDirectionImg": [],
      },
      prepTime: 20,
      cookTime: 20,
      directions: [
        "Place the eggs, salt and pepper in a bowl. Stir to combine",
        "Place the flour and 1/2 cup of cornstarch in a shallow bowl or on a plate. Stir to combine.",
        "Dip each piece of chicken into the egg mixture, then into the flour. Repeat the process with all of the chicken.",
        "Heat 3 inches of oil in a deep pan to 350 degrees F",
        "Add 7-8 pieces of chicken to the pan. Cook for 5 minutes or until crispy and golden brown. Repeat the process with the remaining chicken",
        "Drain the chicken on paper towels",
        "While the chicken is cooking, combine the honey, soy sauce, ketchup, brown sugar, rice vinegar, sesame oil and 2 teaspoons of cornstarch in a bowl."
      ],
      ingredients: [
        "1 1/2 lbs chicken breast",
        "2 eggs beaten",
        "salt and papper to taste",
        "1/2 cup all purpose flour",
        "1/2 cup cornstarch",
        "oil for frying",
        "1 teaspoon vegetable oil",
        "1 teaspoon minced fresh garlic",
        "1/4 cup honey",
        "1/4 cup soy sauce (reduced sodium if possible)",
        "2 tablespoons ketchup",
        "3 tablespoons brown sugar",
        "2 tablespoons rice vinegar",
        "1 tablespoon toasted sesame oil",
        "2 teaspoons cornstarch",
        "2 tablespoons sesame seeds",
        "2 tablespoons sliced green onions",
      ],
    ),
    Recipe(
      title: "Shiitake Mushroom Stir Fry",
      category: "Main Courses",
      difficulty: "Not too tricky",
      images: {
        "titleImg": Assets.images.shiitake.path,
        "cookingDirectionImg": [],
      },
      prepTime: 15,
      cookTime: 20,
      directions: [],
      ingredients: [],
    ),
    Recipe(
      title: "3-Ingredient-Pizza",
      category: "Appetizers",
      difficulty: "Easy",
      images: {
        "titleImg": Assets.images.pizza.path,
        "cookingDirectionImg": [],
      },
      prepTime: 15,
      cookTime: 22,
      directions: [],
      ingredients: [],
    ),
  ];

  final List<ShoppingList> _shoppingListData = [
    ShoppingList("All-purpose list", [])
  ];

  @override
  void addRecipe(Recipe newRecipe) {
    _recipeData.add(newRecipe);
  }

  @override
  List<Recipe> getAllRecipes() {
    return _recipeData;
  }

  @override
  void removeRecipe(String id) {
    _recipeData.remove(id);
  }

  @override
  void addShoppingList(ShoppingList newShoppingList) {
    _shoppingListData.add(newShoppingList);
  }

  @override
  List<ShoppingList> getAllShoppingLists() {
    return _shoppingListData;
  }

  @override
  void removeShoppingList(String id) {
    _shoppingListData.remove(id);
  }
}
