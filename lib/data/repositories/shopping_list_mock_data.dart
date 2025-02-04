import 'package:dishdrop_app_projekt/data/models/list_item.dart';
import 'package:dishdrop_app_projekt/data/models/shopping_list.dart';

final List<ShoppingList> shoppingListData = [
  ShoppingList(
    "All-purpose list",
    [
      ListItem(
        description: "olive oil",
        isShoppingListItem: true,
      ),
      ListItem(
        description: "detergent",
        isShoppingListItem: true,
      ),
      ListItem(
        description: "paper towel",
        isShoppingListItem: true,
      ),
    ],
  ),
];
