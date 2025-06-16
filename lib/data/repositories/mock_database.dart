import 'package:dishdrop_app_projekt/data/models/list_item.dart';
import 'package:dishdrop_app_projekt/data/repositories/recipe_mock_data.dart';
import 'package:dishdrop_app_projekt/gen/assets.gen.dart';

import '../models/recipe.dart';
import '../models/shopping_list.dart';
import 'database_repository.dart';

class MockDatabase implements DatabaseRepository {
  // RECIPES
  // create
  @override
  void addRecipe(Recipe newRecipe) {
    recipeData.add(newRecipe);
  }

  @override
  List<Recipe> getAllRecipes() {
    return recipeData;
  }

  @override
  void removeRecipe(Recipe recipe) {
    recipeData.remove(recipe);
  }

  @override
  void updateRecipe(int oldRecipeId, Recipe newRecipe) {
    final foundRecipe = recipeData.firstWhere((recipe) => recipe.id == oldRecipeId);
    final index = recipeData.indexOf(foundRecipe);

    recipeData[index] = newRecipe;

    // if (recipeData.contains(oldRecipe)) {
    //   final index = recipeData.indexOf(oldRecipe);
    //   recipeData[index] = newRecipe;
    // }
  }

  @override
  Recipe? getRecipeById(int id) {
    final foundRecipe = recipeData.firstWhere((recipe) => recipe.id == id);
    final index = recipeData.indexOf(foundRecipe);

    return recipeData[index];
  }

  // @override
  // void addShoppingList(ShoppingList newShoppingList) {
  //   shoppingListData.add(newShoppingList);
  // }

  // @override
  // void addToAllPurposeShoppingList(ListItem listItem) {
  //   shoppingListData[0].addShoppingItem(listItem);
  // }

  // @override
  // List<ShoppingList> getAllShoppingLists() {
  //   return shoppingListData;
  // }

  // @override
  // void removeShoppingList(ShoppingList shoppingList) {
  //   shoppingListData.remove(shoppingList);
  // }

  // @override
  // void updateShoppingList(ShoppingList oldShoppingList, ShoppingList newShoppingList) {
  //   if (shoppingListData.contains(oldShoppingList)) {
  //     final index = shoppingListData.indexOf(oldShoppingList);
  //     shoppingListData[index] = newShoppingList;
  //   }
  // }

  @override
  void assignShoppingListToRecipe(Recipe recipe, ShoppingList shoppingList) {
    throw UnimplementedError();
  }

  @override
  ShoppingList? getAllPurposeShoppingList() {
    return ShoppingList(
      title: "All-Purpose list",
      imgUrl: Assets.images.shoppingItems.path,
      isAllPurposeList: true,
    );
  }

  @override
  ShoppingList? getRecipeShoppingListById(int id) {
    throw UnimplementedError();
  }

  @override
  List<ShoppingList> getRecipeShoppingLists() {
    return [];
  }

  @override
  void removeFromAllPurposeShoppingList(int id) {
    throw UnimplementedError();
  }

  @override
  void removeFromRecipeShoppingList(int shoppingListId, int id) {
    throw UnimplementedError();
  }

  @override
  void removeRecipeShoppingList(ShoppingList shoppingList) {
    throw UnimplementedError();
  }

  @override
  void updateAllPurposeShoppingListItem(ListItem updatedItem) {
    throw UnimplementedError();
  }

  @override
  void updateRecipeShoppingList(int id, ShoppingList newShoppingList) {
    throw UnimplementedError();
  }

  @override
  void updateRecipeShoppingListItem(int shoppingListId, ListItem updatedItem) {
    throw UnimplementedError();
  }

  @override
  void addToAllPurposeShoppingList(ListItem listItem) {
    throw UnimplementedError();
  }
}
