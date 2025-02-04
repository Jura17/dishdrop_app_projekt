import 'list_item.dart';

class ShoppingList {
  bool isGeneralPurposeList;
  String title;
  int servings;
  List<ListItem> shoppingItems = [];

  ShoppingList({
    this.isGeneralPurposeList = false,
    required this.title,
    this.servings = 0,
    required this.shoppingItems,
  });

  void addShoppingItem(ListItem newShoppingItem) {
    shoppingItems.add(newShoppingItem);
  }

  void setShoppingItem(int index, ListItem newShoppingItem) {
    shoppingItems[index] = newShoppingItem;
  }

  void removeIngredient(int index) {
    shoppingItems.removeAt(index);
  }

  /*
  isGeneralPurposeList bestimmt später, ob es sich um die allgemeine Einkaufsliste handelt, 
  die nicht vom Nutzer erstellt oder gelöscht werden kann und genutzt wird, 
  um auch Dinge wie Spülmittel oder anderes was nicht speziell zu einem Rezept passt, auf die Liste zu setzen
   */
}
