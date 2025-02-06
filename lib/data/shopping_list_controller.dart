import 'package:dishdrop_app_projekt/data/models/shopping_list.dart';
import 'package:dishdrop_app_projekt/data/repositories/database_repository.dart';

class ShoppingListController {
  final DatabaseRepository _databaseRepository;
  ShoppingListController(this._databaseRepository);

  List<ShoppingList> getAllShoppingLists() =>
      _databaseRepository.getAllShoppingLists();
  void addShoppingList(ShoppingList newShoppingList) =>
      _databaseRepository.addShoppingList(newShoppingList);
  void removeShoppingList(int id) => _databaseRepository.removeShoppingList(id);
}
