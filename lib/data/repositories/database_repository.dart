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

  // delete
  void removeRecipe(Recipe recipe);

  // update
  void updateRecipe(int id, Recipe recipe);

  // SHOPPING LIST:
  // create
  void addShoppingList(ShoppingList newShoppingList, Recipe recipe);
  void attachRelationShoppingList(ShoppingList shoppingList);
  void addToAllPurposeShoppingList(ListItem listItem);

  // read
  List<ShoppingList> recipeShoppingLists();
  ShoppingList? getAllPurposeShoppingList();

  // delete
  void removeShoppingList(ShoppingList shoppingList);
  void removeFromAllPurposeShoppingList(int id);

  // update
  void updateShoppingList(ShoppingList oldShoppingList, ShoppingList newShoppingList);
  void updateAllPurposeShoppingList(ListItem updatedItem);
}
