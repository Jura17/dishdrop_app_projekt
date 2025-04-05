import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:objectbox/objectbox.dart';

import 'list_item.dart';

@Entity()
class ShoppingList {
  @Id()
  int id = 0;

  bool isGeneralPurposeList;
  String title;
  String imgUrl;
  int servings;

  final ToMany<ListItem> shoppingItems = ToMany<ListItem>();
  final ToOne<Recipe> recipe = ToOne<Recipe>();
  // List<ListItem> shoppingItems = [];

  ShoppingList({
    this.id = 0,
    this.isGeneralPurposeList = false,
    required this.title,
    required this.imgUrl,
    this.servings = 1,
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
