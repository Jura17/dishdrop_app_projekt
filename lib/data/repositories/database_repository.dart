import '../models/recipe.dart';
import '../models/shopping_list.dart';

abstract class DatabaseRepository {
  // RECIPES:
  // create
  void addRecipe(Recipe newRecipe);

  // read
  List<Recipe> getAllRecipes();

  // delete
  void removeRecipe(String id);

  // SHOPPING LIST:
  // create
  void addShoppingList(ShoppingList newShoppingList);

  // read
  List<ShoppingList> getAllShoppingLists();

  // delete
  void removeShoppingList(String id);

  // Die einzelnen items einer Einkaufsliste verwalte ich vermutlich fürs erste in der App.
  // Das heißt, wenn der Nutzer ein Item zu einer Liste hinzufügt, aktualisiert, entfernt etc. dann geschieht das in der App
  // Anschließend wird die Einkaufsliste wieder in die Datenbank geschoben und überschreibt die alte.
  // Dies könnte in regelmäßigen Abständen passieren oder jedes Mal, wenn sich etwas ändert.
}
