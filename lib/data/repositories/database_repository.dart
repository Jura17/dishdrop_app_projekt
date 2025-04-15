import 'package:dishdrop_app_projekt/data/models/list_item.dart';

import '../models/recipe.dart';
import '../models/shopping_list.dart';

abstract class DatabaseRepository {
  // RECIPES:
  // create
  void addRecipe(Recipe newRecipe);

  // read
  Stream<List<Recipe>> getAllRecipes();

  // delete
  void removeRecipe(Recipe recipe);

  // update
  void updateRecipe(Recipe oldRecipe, Recipe newRecipe);

  // SHOPPING LIST:
  // create
  void addShoppingList(ShoppingList newShoppingList);
  void addToAllPurposeShoppingList(ListItem listItem);

  // read
  Stream<List<ShoppingList>> getRecipeShoppingLists();
  Stream<ShoppingList?> getAllPurposeShoppingList();

  // delete
  void removeShoppingList(ShoppingList shoppingList);

  // update
  void updateShoppingList(ShoppingList oldShoppingList, ShoppingList newShoppingList);
}
