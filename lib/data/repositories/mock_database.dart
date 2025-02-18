import 'package:dishdrop_app_projekt/data/models/list_item.dart';
import 'package:dishdrop_app_projekt/data/repositories/recipe_mock_data.dart';
import 'package:dishdrop_app_projekt/data/repositories/shopping_list_mock_data.dart';

import '../models/recipe.dart';
import '../models/shopping_list.dart';
import 'database_repository.dart';

class MockDatabase implements DatabaseRepository {
  @override
  List<Recipe> getAllRecipes() {
    return recipeData;
  }

  @override
  void addRecipe(Recipe newRecipe) {
    recipeData.add(newRecipe);
  }

  @override
  void removeRecipe(Recipe recipe) {
    recipeData.remove(recipe);
  }

  @override
  void updateRecipe(Recipe oldRecipe, Recipe newRecipe) {
    if (recipeData.contains(oldRecipe)) {
      final index = recipeData.indexOf(oldRecipe);
      recipeData[index] = newRecipe;
    }
  }

  @override
  void addShoppingList(ShoppingList newShoppingList) {
    shoppingListData.add(newShoppingList);
  }

  @override
  void addToAllPurposeShoppingList(ListItem listItem) {
    shoppingListData[0].addShoppingItem(listItem);
  }

  @override
  List<ShoppingList> getAllShoppingLists() {
    return shoppingListData;
  }

  @override
  void removeShoppingList(ShoppingList shoppingList) {
    shoppingListData.remove(shoppingList);
  }

  @override
  void updateShoppingList(
      ShoppingList oldShoppingList, ShoppingList newShoppingList) {
    if (shoppingListData.contains(oldShoppingList)) {
      final index = shoppingListData.indexOf(oldShoppingList);
      shoppingListData[index] = newShoppingList;
    }
  }
}
