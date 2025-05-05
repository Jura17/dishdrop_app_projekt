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
    _recipeShoppingLists = _databaseRepository.recipeShoppingLists();
    notifyListeners();
  }

  void loadAllPurposeShoppingList() {
    _allPurposeShoppingList = _databaseRepository.allPurposeShoppingList();
    notifyListeners();
  }

  List<ShoppingList> get recipeShoppingLists => _recipeShoppingLists;
  ShoppingList? get allPurposeShoppingList => _allPurposeShoppingList;

  void addShoppingList(ShoppingList newShoppingList, Recipe recipe) {
    _databaseRepository.addShoppingList(newShoppingList, recipe);
    notifyListeners();
  }

  void attachRelationShoppingList(ShoppingList shoppingList) {
    _databaseRepository.attachRelationShoppingList(shoppingList);
  }

  void removeShoppingList(ShoppingList shoppingList) {
    _databaseRepository.removeShoppingList(shoppingList);
    notifyListeners();
  }

  void addToAllPurposeShoppingList(ListItem listItem) {
    _databaseRepository.addToAllPurposeShoppingList(listItem);
    notifyListeners();
  }

  void updateShoppingList(ShoppingList oldShoppingList, ShoppingList newShoppingList) {
    _databaseRepository.updateShoppingList(oldShoppingList, newShoppingList);
    notifyListeners();
  }
}
