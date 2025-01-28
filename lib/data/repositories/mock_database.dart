import '../models/recipe.dart';
import '../models/shopping_list.dart';
import 'database_repository.dart';

class MockDatabase implements DatabaseRepository {
  final List<Recipe> _recipeData = [];
  final List<ShoppingList> _shoppingListData = [
    ShoppingList("All-purpose list", [])
  ];

  @override
  void addRecipe(Recipe newRecipe) {
    _recipeData.add(newRecipe);
  }

  @override
  List<Recipe> getAllRecipes() {
    return _recipeData;
  }

  @override
  void removeRecipe(String id) {
    _recipeData.remove(id);
  }

  @override
  void addShoppingList(ShoppingList newShoppingList) {
    _shoppingListData.add(newShoppingList);
  }

  @override
  List<ShoppingList> getAllShoppingLists() {
    return _shoppingListData;
  }

  @override
  void removeShoppingList(String id) {
    _shoppingListData.remove(id);
  }
}
