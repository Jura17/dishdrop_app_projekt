import 'package:dishdrop_app_projekt/data/models/list_item.dart';
import 'package:dishdrop_app_projekt/data/models/shopping_list.dart';
import 'package:dishdrop_app_projekt/data/repositories/database_repository.dart';

class ShoppingListController {
  final DatabaseRepository _databaseRepository;
  ShoppingListController(this._databaseRepository);

  ShoppingList? getAllPurposeShoppingList() => _databaseRepository.getAllPurposeShoppingList();
  List<ShoppingList> getRecipeShoppingLists() => _databaseRepository.getRecipeShoppingLists();
  void addShoppingList(ShoppingList newShoppingList) => _databaseRepository.addShoppingList(newShoppingList);
  void removeShoppingList(ShoppingList shoppingList) => _databaseRepository.removeShoppingList(shoppingList);
  void addToAllPurposeShoppingList(ListItem listItem) => _databaseRepository.addToAllPurposeShoppingList(listItem);
  void updateShoppingList(ShoppingList oldShoppingList, ShoppingList newShoppingList) =>
      _databaseRepository.updateShoppingList(oldShoppingList, newShoppingList);
}
