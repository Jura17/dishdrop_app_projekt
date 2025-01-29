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
        "titleImg": Assets.images.mainCoursesCategoryImg,
        "cookingDirectionImg": [],
      },
      prepTime: 20,
      cookTime: 20,
      directions: [],
      ingredients: [],
    ),
    Recipe(
      title: "Shiitake Mushroom Stir Fry",
      category: "Main Courses",
      difficulty: "Not too tricky",
      images: {
        "titleImg": Assets.images.shiitake,
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
        "titleImg": Assets.images.pizza,
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
