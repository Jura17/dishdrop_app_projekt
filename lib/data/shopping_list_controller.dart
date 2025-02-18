import 'package:dishdrop_app_projekt/data/models/shopping_list.dart';
import 'package:dishdrop_app_projekt/data/repositories/database_repository.dart';

class ShoppingListController {
  final DatabaseRepository _databaseRepository;
  ShoppingListController(this._databaseRepository);

  Future<List<ShoppingList>> getAllShoppingListsFuture() => Future.delayed(
        Duration(seconds: 3),
        () => _databaseRepository.getAllShoppingLists(),
      );

  Future<void> addShoppingListFuture(ShoppingList newShoppingList) =>
      Future.delayed(
        Duration(seconds: 3),
        () => _databaseRepository.addShoppingList(newShoppingList),
      );

  Future<void> removeShoppingListFuture(ShoppingList shoppingList) =>
      Future.delayed(
        Duration(seconds: 3),
        () => _databaseRepository.removeShoppingList(shoppingList),
      );

  Future<void> updateShoppingListFuture(
          ShoppingList oldShoppingList, ShoppingList newShoppingList) =>
      Future.delayed(
          Duration(seconds: 3),
          () => _databaseRepository.updateShoppingList(
              oldShoppingList, newShoppingList));

  // TODO: remove old methods later
  List<ShoppingList> getAllShoppingLists() =>
      _databaseRepository.getAllShoppingLists();
  void addShoppingList(ShoppingList newShoppingList) =>
      _databaseRepository.addShoppingList(newShoppingList);
  void removeShoppingList(ShoppingList shoppingList) =>
      _databaseRepository.removeShoppingList(shoppingList);
  void updateShoppingList(
          ShoppingList oldShoppingList, ShoppingList newShoppingList) =>
      _databaseRepository.updateShoppingList(oldShoppingList, newShoppingList);
}
