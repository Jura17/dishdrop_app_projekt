import 'package:dishdrop_app_projekt/data/models/list_item.dart';
import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/models/shopping_list.dart';
import 'package:dishdrop_app_projekt/data/repositories/database_repository.dart';
import 'package:flutter/material.dart';

class ShoppingListNotifier extends ChangeNotifier {
  List<ShoppingList> _recipeShoppingLists = [];
  ShoppingList? _allPurposeShoppingList;
  final DatabaseRepository _databaseRepository;

  ShoppingListNotifier(this._databaseRepository) {
    loadRecipeShoppingLists();
    loadAllPurposeShoppingList();
  }

  void loadRecipeShoppingLists() {
    _recipeShoppingLists = _databaseRepository.getRecipeShoppingLists();
    notifyListeners();
  }

  void loadAllPurposeShoppingList() {
    _allPurposeShoppingList = _databaseRepository.getAllPurposeShoppingList();
    notifyListeners();
  }

  List<ShoppingList> get recipeShoppingLists => _recipeShoppingLists;
  ShoppingList? get allPurposeShoppingList => _allPurposeShoppingList;

  ShoppingList? getRecipeShoppingListById(int id) {
    return _databaseRepository.getRecipeShoppingListById(id);
  }

  void addShoppingList(ShoppingList newShoppingList, Recipe recipe) {
    _databaseRepository.addShoppingList(newShoppingList, recipe);
    notifyListeners();
  }

  void attachRelationShoppingList(ShoppingList shoppingList) {
    _databaseRepository.attachRelationShoppingList(shoppingList);
  }

  void removeRecipeShoppingList(ShoppingList shoppingList) {
    _databaseRepository.removeRecipeShoppingList(shoppingList);
    _recipeShoppingLists.remove(shoppingList);
    notifyListeners();
  }

  void addToAllPurposeShoppingList(ListItem listItem) {
    _databaseRepository.addToAllPurposeShoppingList(listItem);
    notifyListeners();
  }

  void updateAllPurposeShoppingList(ListItem updatedItem) {
    _databaseRepository.updateAllPurposeShoppingList(updatedItem);
    notifyListeners();
  }

  void removeFromAllPurposeShoppingList(int id) {
    _databaseRepository.removeFromAllPurposeShoppingList(id);
    notifyListeners();
  }

  void removeFromRecipeShoppingList(int shoppingListId, int id) {
    _databaseRepository.removeFromRecipeShoppingList(shoppingListId, id);
    notifyListeners();
  }

  void updateRecipeShoppingList(int id, ShoppingList updatedShoppingList) {
    _databaseRepository.updateRecipeShoppingList(id, updatedShoppingList);
    final index = _recipeShoppingLists.indexWhere((shoppingList) => shoppingList.id == id);
    _recipeShoppingLists[index] = updatedShoppingList;
    notifyListeners();
  }

  void updateRecipeShoppingListItem(int shoppingListId, ListItem updatedItem) {
    _databaseRepository.updateRecipeShoppingListItem(shoppingListId, updatedItem);
    notifyListeners();
  }
}
