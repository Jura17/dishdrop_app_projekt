import 'package:dishdrop_app_projekt/data/models/list_item.dart';
import 'package:dishdrop_app_projekt/data/models/shopping_list.dart';
import 'package:dishdrop_app_projekt/data/repositories/database_repository.dart';
import 'package:flutter/material.dart';

class ShoppingListNotifier extends ChangeNotifier {
  final DatabaseRepository _databaseRepository;

  ShoppingListNotifier(this._databaseRepository);

  ShoppingList? getAllPurposeShoppingList() {
    return _databaseRepository.getAllPurposeShoppingList();
  }

  List<ShoppingList> getRecipeShoppingLists() {
    return _databaseRepository.getRecipeShoppingLists();
  }

  void addShoppingList(ShoppingList newShoppingList) {
    _databaseRepository.addShoppingList(newShoppingList);
    notifyListeners();
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
