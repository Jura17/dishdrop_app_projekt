import 'package:dishdrop_app_projekt/data/models/list_item.dart';
import 'package:dishdrop_app_projekt/data/models/shopping_list.dart';
import 'package:dishdrop_app_projekt/data/repositories/database_repository.dart';

class ShoppingListController {
  final DatabaseRepository _databaseRepository;
  ShoppingListController(this._databaseRepository);

  // Future<List<ShoppingList>> getAllShoppingListsFuture() => Future.delayed(
  //       Duration(seconds: 2),
  //       () => _databaseRepository.getAllShoppingLists(),
  //     );

  // Future<void> addShoppingListFuture(ShoppingList newShoppingList) =>
  //     Future.delayed(
  //       Duration(seconds: 2),
  //       () => _databaseRepository.addShoppingList(newShoppingList),
  //     );

  // Future<void> removeShoppingListFuture(ShoppingList shoppingList) =>
  //     Future.delayed(
  //       Duration(seconds: 2),
  //       () => _databaseRepository.removeShoppingList(shoppingList),
  //     );

  // Future<void> updateShoppingListFuture(
  //         ShoppingList oldShoppingList, ShoppingList newShoppingList) =>
  //     Future.delayed(
  //         Duration(seconds: 2),
  //         () => _databaseRepository.updateShoppingList(
  //             oldShoppingList, newShoppingList));

  Stream<ShoppingList?> getAllPurposeShoppingList() => _databaseRepository.getAllPurposeShoppingList();
  Stream<List<ShoppingList>> getRecipeShoppingLists() => _databaseRepository.getRecipeShoppingLists();
  void addShoppingList(ShoppingList newShoppingList) => _databaseRepository.addShoppingList(newShoppingList);
  void removeShoppingList(ShoppingList shoppingList) => _databaseRepository.removeShoppingList(shoppingList);
  void addToAllPurposeShoppingList(ListItem listItem) => _databaseRepository.addToAllPurposeShoppingList(listItem);
  void updateShoppingList(ShoppingList oldShoppingList, ShoppingList newShoppingList) =>
      _databaseRepository.updateShoppingList(oldShoppingList, newShoppingList);
}
