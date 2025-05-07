import 'package:dishdrop_app_projekt/data/models/cooking_direction.dart';
import 'package:dishdrop_app_projekt/data/models/list_item.dart';
import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/models/shopping_list.dart';
import 'package:dishdrop_app_projekt/data/repositories/database_repository.dart';
import 'package:dishdrop_app_projekt/objectbox.g.dart';

class ObjectboxDatabase implements DatabaseRepository {
  final Box<Recipe> recipeBox;
  final Box<ShoppingList> shoppingListBox;
  final Box<ListItem> listItemBox;
  final Box<CookingDirection> cookingDirectionBox;
  final Store store;

  ObjectboxDatabase(this.store)
      : recipeBox = store.box<Recipe>(),
        shoppingListBox = store.box<ShoppingList>(),
        listItemBox = store.box<ListItem>(),
        cookingDirectionBox = store.box<CookingDirection>();

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
  void updateRecipe(int oldRecipeId, Recipe newRecipe) {
    final Recipe? oldRecipe = recipeBox.get(oldRecipeId);
    if (oldRecipe == null) return;

    // Delete removed ListItems
    final oldItemIds = oldRecipe.ingredients.map((e) => e.id).toSet();
    final newItemIds = newRecipe.ingredients.map((e) => e.id).toSet();
    final removedItemIds = oldItemIds.difference(newItemIds);
    for (final id in removedItemIds) {
      listItemBox.remove(id);
    }

    // Delete removed CookingDirections
    final oldDirIds = oldRecipe.directions.map((e) => e.id).toSet();
    final newDirIds = newRecipe.directions.map((e) => e.id).toSet();
    final removedDirIds = oldDirIds.difference(newDirIds);
    for (final id in removedDirIds) {
      cookingDirectionBox.remove(id);
    }

    newRecipe.id = oldRecipeId;
    recipeBox.put(newRecipe);
  }

  @override
  void removeRecipe(Recipe recipe) {
    // ToMany relationships need to be removed manually in ObjectBox...
    for (var listItem in recipe.ingredients) {
      listItemBox.remove(listItem.id);
    }
    for (var cookingDirection in recipe.directions) {
      cookingDirectionBox.remove(cookingDirection.id);
    }
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

  @override
  void updateAllPurposeShoppingList(ListItem updatedItem) {
    final query = shoppingListBox.query(ShoppingList_.isAllPurposeList.equals(true)).build();
    var allPurposeShoppingList = query.findFirst();
    query.close();

    if (allPurposeShoppingList != null) {
      final index = allPurposeShoppingList.shoppingItems.indexWhere((item) => item.id == updatedItem.id);
      if (index != -1) {
        allPurposeShoppingList.shoppingItems[index] = updatedItem;
        listItemBox.put(updatedItem);
        shoppingListBox.put(allPurposeShoppingList);
      }
    }
  }

  @override
  void removeFromAllPurposeShoppingList(int id) {
    final ShoppingList? allPurposeShoppingList = getAllPurposeShoppingList();
    if (allPurposeShoppingList != null) {
      allPurposeShoppingList.shoppingItems.removeWhere((ingredient) => ingredient.id == id);
      shoppingListBox.put(allPurposeShoppingList);
    }
  }

  @override
  void removeFromRecipeShoppingList(int shoppingListId, int id) {
    final ShoppingList? recipeShoppingList = shoppingListBox.get(shoppingListId);
    if (recipeShoppingList != null) {
      recipeShoppingList.shoppingItems.removeWhere((ingredient) => ingredient.id == id);
      shoppingListBox.put(recipeShoppingList);
    }
  }

  @override
  ShoppingList? getAllPurposeShoppingList() {
    final allPurposeShoppingList =
        shoppingListBox.getAll().where((shoppingList) => shoppingList.isAllPurposeList == true).first;
    return allPurposeShoppingList;
  }

  @override
  List<ShoppingList> getRecipeShoppingLists() {
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
