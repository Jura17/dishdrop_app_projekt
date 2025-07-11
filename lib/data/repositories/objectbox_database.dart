import 'package:dishdrop_app_projekt/data/models/cooking_direction.dart';
import 'package:dishdrop_app_projekt/data/models/list_item.dart';
import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/models/shopping_list.dart';
import 'package:dishdrop_app_projekt/data/repositories/database_repository.dart';
import 'package:dishdrop_app_projekt/data/repositories/recipe_mock_data.dart';
import 'package:dishdrop_app_projekt/gen/assets.gen.dart';
import 'package:dishdrop_app_projekt/objectbox.g.dart';

class ObjectboxDatabase implements DatabaseRepository {
  final Box<Recipe> _recipeBox;
  final Box<ShoppingList> _shoppingListBox;
  final Box<ListItem> _listItemBox;
  final Box<CookingDirection> _cookingDirectionBox;
  final Store store;

  ObjectboxDatabase(this.store)
      : _recipeBox = store.box<Recipe>(),
        _shoppingListBox = store.box<ShoppingList>(),
        _listItemBox = store.box<ListItem>(),
        _cookingDirectionBox = store.box<CookingDirection>() {
    // Use to fill database with mock data:
    if (_recipeBox.isEmpty()) _recipeBox.putMany(recipeData);
    // remove all recipes
    // _recipeBox.removeAll();
    // remove all shopping lists
    // _shoppingListBox.removeAll();

    if (_shoppingListBox.isEmpty()) {
      _shoppingListBox.put(
        ShoppingList(
          title: "All-Purpose list",
          imgUrl: Assets.images.shoppingItems.path,
          isAllPurposeList: true,
        ),
      );
    }
  }

  // CREATE
  @override
  void addRecipe(Recipe newRecipe) {
    _recipeBox.put(newRecipe);
  }

  // connect shopping list to a recipe
  @override
  void assignShoppingListToRecipe(Recipe recipe, ShoppingList shoppingList) {
    recipe.shoppingList.attach(store);
    shoppingList.recipe.attach(store);

    recipe.shoppingList.target = shoppingList;
    shoppingList.recipe.target = recipe;

    _shoppingListBox.put(shoppingList);
    _recipeBox.put(recipe);
  }

  // add new item to all-purpose shopping list
  @override
  void addToAllPurposeShoppingList(ListItem listItem) {
    final query = _shoppingListBox.query(ShoppingList_.isAllPurposeList.equals(true)).build();
    var allPurposeShoppingList = query.findFirst();
    query.close();

    if (allPurposeShoppingList != null) {
      allPurposeShoppingList.shoppingItems.add(listItem);
      _shoppingListBox.put(allPurposeShoppingList);
    }
  }

  // READ
  @override
  Recipe? getRecipeById(int id) {
    final recipe = _recipeBox.get(id);
    return recipe;
  }

  @override
  List<Recipe> getAllRecipes() {
    return _recipeBox.getAll();
  }

  @override
  ShoppingList? getAllPurposeShoppingList() {
    final allPurposeShoppingList =
        _shoppingListBox.getAll().where((shoppingList) => shoppingList.isAllPurposeList == true).first;
    return allPurposeShoppingList;
  }

  @override
  List<ShoppingList> getRecipeShoppingLists() {
    final recipeShoppingLists =
        _shoppingListBox.getAll().where((shoppingList) => shoppingList.isAllPurposeList == false).toList();
    return recipeShoppingLists;
  }

  @override
  ShoppingList? getRecipeShoppingListById(int id) {
    final shoppingList = _shoppingListBox.get(id);
    shoppingList?.recipe.attach(store);

    return shoppingList;
  }

  // UPDATE
  @override
  void updateRecipe(int oldRecipeId, Recipe newRecipe) {
    final Recipe? oldRecipe = _recipeBox.get(oldRecipeId);
    if (oldRecipe == null) return;

    // Delete removed ListItems
    final oldItemIds = oldRecipe.ingredients.map((ingredient) => ingredient.id).toSet();
    final newItemIds = newRecipe.ingredients.map((ingredient) => ingredient.id).toSet();
    final removedItemIds = oldItemIds.difference(newItemIds);
    for (final id in removedItemIds) {
      _listItemBox.remove(id);
    }

    // Delete removed CookingDirections
    final oldDirIds = oldRecipe.directions.map((ingredient) => ingredient.id).toSet();
    final newDirIds = newRecipe.directions.map((ingredient) => ingredient.id).toSet();
    final removedDirIds = oldDirIds.difference(newDirIds);
    for (final id in removedDirIds) {
      _cookingDirectionBox.remove(id);
    }

    newRecipe.id = oldRecipeId;
    _recipeBox.put(newRecipe);
  }

  @override
  void updateAllPurposeShoppingListItem(ListItem updatedItem) {
    final ShoppingList? allPurposeShoppingList = getAllPurposeShoppingList();

    if (allPurposeShoppingList != null) {
      final index = allPurposeShoppingList.shoppingItems.indexWhere((item) => item.id == updatedItem.id);
      if (index != -1) {
        allPurposeShoppingList.shoppingItems[index] = updatedItem;
        _listItemBox.put(updatedItem);
        _shoppingListBox.put(allPurposeShoppingList);
      }
    }
  }

  @override
  void updateRecipeShoppingList(int id, ShoppingList newShoppingList) {
    newShoppingList.id = id;
    _shoppingListBox.put(newShoppingList);
  }

  @override
  void updateRecipeShoppingListItem(int shoppingListId, ListItem updatedItem) {
    final ShoppingList? recipeShoppingList = _shoppingListBox.get(shoppingListId);
    if (recipeShoppingList != null) {
      final index = recipeShoppingList.shoppingItems.indexWhere((item) => item.id == updatedItem.id);
      if (index != -1) {
        recipeShoppingList.shoppingItems[index] = updatedItem;
        _listItemBox.put(updatedItem);
        _shoppingListBox.put(recipeShoppingList);
      }
    }
  }

  // DELETE
  @override
  void removeRecipe(Recipe recipe) {
    // ToMany-relationships need to be removed manually in ObjectBox
    for (var listItem in recipe.ingredients) {
      _listItemBox.remove(listItem.id);
    }
    for (var cookingDirection in recipe.directions) {
      _cookingDirectionBox.remove(cookingDirection.id);
    }
    _recipeBox.remove(recipe.id);
  }

  @override
  void removeRecipeShoppingList(ShoppingList shoppingList) {
    // reset all shopping items for that shopping list
    for (var item in shoppingList.shoppingItems) {
      item.isDone = false;
      _listItemBox.put(item);
    }
    _shoppingListBox.remove(shoppingList.id);
  }

  @override
  void removeFromAllPurposeShoppingList(int id) {
    final ShoppingList? allPurposeShoppingList = getAllPurposeShoppingList();
    if (allPurposeShoppingList != null) {
      allPurposeShoppingList.shoppingItems.removeWhere((ingredient) => ingredient.id == id);
      _shoppingListBox.put(allPurposeShoppingList);
    }
  }

  @override
  void removeFromRecipeShoppingList(int shoppingListId, int itemId) {
    final ShoppingList? recipeShoppingList = _shoppingListBox.get(shoppingListId);
    if (recipeShoppingList != null) {
      final index = recipeShoppingList.shoppingItems.indexWhere((item) => item.id == itemId);
      if (index != -1) {
        final item = recipeShoppingList.shoppingItems[index];
        item.isDone = false;
        _listItemBox.put(item);
      }

      recipeShoppingList.shoppingItems.removeAt(index);
      _shoppingListBox.put(recipeShoppingList);
    }
  }
}
