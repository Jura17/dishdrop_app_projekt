import 'list_item.dart';

class ShoppingList {
  String id;
  bool isGeneralPurposeList;
  String title;
  String imgUrl;
  int servings;
  List<ListItem> shoppingItems = [];

  ShoppingList({
    required this.id,
    this.isGeneralPurposeList = false,
    required this.title,
    required this.imgUrl,
    this.servings = 1,
    required this.shoppingItems,
  });

  void addShoppingItem(ListItem newShoppingItem) {
    shoppingItems.add(newShoppingItem);
  }

  void setShoppingItem(int index, ListItem newShoppingItem) {
    shoppingItems[index] = newShoppingItem;
  }

  void removeFromShoppingList(ListItem listItem) {
    shoppingItems.remove(listItem);
  }
}
