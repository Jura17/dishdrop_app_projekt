import 'package:dishdrop_app_projekt/data/models/list_item.dart';
import 'package:dishdrop_app_projekt/data/models/shopping_list.dart';

final List<ShoppingList> shoppingListData = [
  ShoppingList(
    title: "All-purpose list",
    shoppingItems: [
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
  ShoppingList(
    title: "Sesame Chicken",
    servings: 4,
    shoppingItems: [
      ListItem(
          amount: 1.5,
          unit: "lbs",
          description: "chicken breast",
          isShoppingListItem: true),
      ListItem(amount: 2, description: "eggs beaten", isShoppingListItem: true),
      ListItem(
          description: "salt and pepper to taste", isShoppingListItem: true),
      ListItem(
          amount: 0.5,
          unit: "cup",
          description: "all purpose flour",
          isShoppingListItem: true),
      ListItem(
          amount: 0.5,
          unit: "cup",
          description: "cornstarch",
          isShoppingListItem: true),
      ListItem(description: "oil for frying", isShoppingListItem: true),
      ListItem(
          amount: 1,
          unit: "tsp",
          description: "vegetable oil",
          isShoppingListItem: true),
      ListItem(
          amount: 1,
          unit: "tsp",
          description: "minced fresh garlic",
          isShoppingListItem: true),
      ListItem(
          amount: 0.25,
          unit: "cup",
          description: "honey",
          isShoppingListItem: true),
      ListItem(
          amount: 0.25,
          unit: "cup",
          description: "soy sauce (reduced sodium if possible)",
          isShoppingListItem: true),
      ListItem(
          amount: 2,
          unit: "tbsp",
          description: "ketchup",
          isShoppingListItem: true),
      ListItem(
          amount: 3,
          unit: "tbsp",
          description: "brown sugar",
          isShoppingListItem: true),
      ListItem(
          amount: 2,
          unit: "tbsp",
          description: "rice vinegar",
          isShoppingListItem: true),
      ListItem(
          amount: 1,
          unit: "tbsp",
          description: "toasted sesame oil",
          isShoppingListItem: true),
      ListItem(
          amount: 2,
          unit: "tsps",
          description: "cornstarch",
          isShoppingListItem: true),
      ListItem(
          amount: 2,
          unit: "tbsp",
          description: "sesame seeds",
          isShoppingListItem: true),
      ListItem(
          amount: 2,
          unit: "tbsp",
          description: "sliced green onions",
          isShoppingListItem: true),
    ],
  ),
];
