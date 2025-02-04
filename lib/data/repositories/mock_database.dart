import 'package:dishdrop_app_projekt/data/repositories/recipe_mock_data.dart';

import '../models/recipe.dart';
import '../models/shopping_list.dart';
import 'database_repository.dart';

class MockDatabase implements DatabaseRepository {
  final List<ShoppingList> _shoppingListData = [
    ShoppingList("All-purpose list", [])
  ];

  @override
  void addRecipe(Recipe newRecipe) {
    recipeData.add(newRecipe);
  }

  @override
  List<Recipe> getAllRecipes() {
    return recipeData;
  }

  @override
  void removeRecipe(int id) {
    recipeData.removeAt(id);
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
