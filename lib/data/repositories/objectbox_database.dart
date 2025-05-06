import 'package:dishdrop_app_projekt/data/models/list_item.dart';
import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/models/shopping_list.dart';
import 'package:dishdrop_app_projekt/data/repositories/database_repository.dart';
import 'package:dishdrop_app_projekt/objectbox.g.dart';

class ObjectboxDatabase implements DatabaseRepository {
  final Box<Recipe> recipeBox;
  final Box<ShoppingList> shoppingListBox;
  final Store store;

  ObjectboxDatabase(this.store)
      : recipeBox = store.box<Recipe>(),
        shoppingListBox = store.box<ShoppingList>();

  @override
  void addRecipe(Recipe newRecipe) {
    recipeBox.put(newRecipe);
  }

  @override
  Recipe? getRecipeById(int id) {
    final recipe = recipeBox.get(id);
    return recipe;
  }

  @override
  void assignShoppingListToRecipe(Recipe recipe, ShoppingList shoppingList) {
    recipe.shoppingList.attach(store);
    shoppingList.recipe.attach(store);

    recipe.shoppingList.target = shoppingList;
    shoppingList.recipe.target = recipe;

    shoppingListBox.put(shoppingList);
    recipeBox.put(recipe);
  }

  @override
  List<Recipe> getAllRecipes() {
    return recipeBox.getAll();
  }

  @override
  void updateRecipe(Recipe oldRecipe, Recipe newRecipe) {
    newRecipe.id = oldRecipe.id;
    recipeBox.put(newRecipe);
  }

  @override
  void removeRecipe(Recipe recipe) {
    recipeBox.remove(recipe.id);
  }

  @override
  void addShoppingList(ShoppingList newShoppingList, Recipe recipe) {
    newShoppingList.recipe.target = recipe;
    shoppingListBox.put(newShoppingList);

    recipe.shoppingList.target = newShoppingList;
    recipeBox.put(recipe);
  }

  @override
  void attachRelationShoppingList(ShoppingList shoppingList) {
    shoppingList.recipe.attach(store);
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
  // TODO: also needs a remove from list method

  @override
  ShoppingList? allPurposeShoppingList() {
    final allPurposeShoppingList =
        shoppingListBox.getAll().where((shoppingList) => shoppingList.isAllPurposeList == true).first;

    return allPurposeShoppingList;
  }

  @override
  List<ShoppingList> recipeShoppingLists() {
    final recipeShoppingLists =
        shoppingListBox.getAll().where((shoppingList) => shoppingList.isAllPurposeList == false).toList();
    return recipeShoppingLists;
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
