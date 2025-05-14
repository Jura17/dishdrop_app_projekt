import 'package:dishdrop_app_projekt/data/models/list_item.dart';

import '../models/recipe.dart';
import '../models/shopping_list.dart';

abstract class DatabaseRepository {
  // RECIPES:
  // create
  void addRecipe(Recipe newRecipe);
  void assignShoppingListToRecipe(Recipe recipe, ShoppingList shoppingList);

  // read
  List<Recipe> getAllRecipes();
  Recipe? getRecipeById(int id);

  // update
  void updateRecipe(int id, Recipe recipe);

  // delete
  void removeRecipe(Recipe recipe);

  // SHOPPING LIST:
  // create
  void addToAllPurposeShoppingList(ListItem listItem);

  // read
  List<ShoppingList> getRecipeShoppingLists();
  ShoppingList? getAllPurposeShoppingList();
  ShoppingList? getRecipeShoppingListById(int id);

  // update
  void updateRecipeShoppingList(int id, ShoppingList newShoppingList);
  void updateRecipeShoppingListItem(int shoppingListId, ListItem updatedItem);
  void updateAllPurposeShoppingListItem(ListItem updatedItem);

  // delete
  void removeRecipeShoppingList(ShoppingList shoppingList);
  void removeFromAllPurposeShoppingList(int id);
  void removeFromRecipeShoppingList(int shoppingListId, int id);
}
