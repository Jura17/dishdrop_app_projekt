import 'package:dishdrop_app_projekt/data/models/list_item.dart';
import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/models/shopping_list.dart';
import 'package:dishdrop_app_projekt/data/repositories/database_repository.dart';
import 'package:dishdrop_app_projekt/objectbox.g.dart';

class ObjectboxDatabase implements DatabaseRepository {
  final Box<Recipe> recipeBox;
  final Box<ShoppingList> shoppingListBox;

  ObjectboxDatabase(Store store)
      : recipeBox = store.box<Recipe>(),
        shoppingListBox = store.box<ShoppingList>();

  @override
  void addRecipe(Recipe newRecipe) {
    recipeBox.put(newRecipe);
  }

  @override
  List<Recipe> getAllRecipes() {
    return recipeBox.getAll();
  }

  @override
  void updateRecipe(Recipe recipe) {
    recipeBox.put(recipe);
  }

  @override
  void removeRecipe(Recipe recipe) {
    recipeBox.remove(recipe.id);
  }

  @override
  void addShoppingList(ShoppingList newShoppingList) {
    shoppingListBox.put(newShoppingList);
  }

  @override
  void addToAllPurposeShoppingList(ListItem listItem) {
    final query = shoppingListBox.query(ShoppingList_.isAllPurposeList.equals(true)).build();
    var allPurposeShoppingList = query.findFirst();
    query.close();

    if (allPurposeShoppingList != null) {
      allPurposeShoppingList.shoppingItems.add(listItem);
      shoppingListBox.put(allPurposeShoppingList);
    }
  }

  // TODO: needs a remove from list method

  @override
  ShoppingList? getAllPurposeShoppingList() {
    // final query = shoppingListBox.query(ShoppingList_.isAllPurposeList.equals(true)).watch(triggerImmediately: true);
    final allPurposeShoppingList =
        shoppingListBox.getAll().where((shoppingList) => shoppingList.isAllPurposeList == true).first;
    // var allPurposeShoppingList = query.map((shoppinglist) => shoppinglist.findFirst());
    return allPurposeShoppingList;
  }

  @override
  List<ShoppingList> getRecipeShoppingLists() {
    // final query = shoppingListBox.query(ShoppingList_.isAllPurposeList.equals(false)).watch(triggerImmediately: true);
    final recipeShoppingLists =
        shoppingListBox.getAll().where((shoppingList) => shoppingList.isAllPurposeList == false).toList();
    return recipeShoppingLists;
    // return query.map((shoppinglist) => shoppinglist.find());
  }

  @override
  void removeShoppingList(ShoppingList shoppingList) {
    shoppingListBox.remove(shoppingList.id);
  }

  @override
  void updateShoppingList(ShoppingList oldShoppingList, ShoppingList newShoppingList) {
    newShoppingList.id = oldShoppingList.id;
    shoppingListBox.put(newShoppingList);
  }
}
