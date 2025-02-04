import 'package:dishdrop_app_projekt/data/repositories/recipe_mock_data.dart';
import 'package:dishdrop_app_projekt/data/repositories/shopping_list_mock_data.dart';

import '../models/recipe.dart';
import '../models/shopping_list.dart';
import 'database_repository.dart';

class MockDatabase implements DatabaseRepository {
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
    shoppingListData.add(newShoppingList);
  }

  @override
  List<ShoppingList> getAllShoppingLists() {
    return shoppingListData;
  }

  @override
  void removeShoppingList(int id) {
    shoppingListData.removeAt(id);
  }
}
