import 'package:dishdrop_app_projekt/data/models/list_item.dart';
import 'package:dishdrop_app_projekt/data/models/shopping_list.dart';

final List<ShoppingList> shoppingListData = [
  ShoppingList(
    title: "All-purpose list",
    imgUrl: "",
    shoppingItems: [
      ListItem(
        description: "milk",
        amount: 1,
        unit: "gallon",
        isShoppingListItem: true,
      ),
      ListItem(
        description: "bread",
        amount: 2,
        unit: "loaves",
        isShoppingListItem: true,
      ),
      ListItem(
        description: "eggs",
        amount: 12,
        unit: "pieces",
        isShoppingListItem: true,
      ),
      ListItem(
        description: "apples",
        amount: 6,
        unit: "",
        isShoppingListItem: true,
      ),
      ListItem(
        description: "rice",
        amount: 5,
        unit: "lbs",
        isShoppingListItem: true,
      ),
      ListItem(
        description: "chicken",
        amount: 2,
        unit: "lbs",
        isShoppingListItem: true,
      ),
      ListItem(
        description: "toothpaste",
        amount: 1,
        unit: "tube",
        isShoppingListItem: true,
      ),
      ListItem(
        description: "shampoo",
        amount: 1,
        unit: "bottle",
        isShoppingListItem: true,
      ),
      ListItem(
        description: "potatoes",
        amount: 4,
        unit: "lbs",
        isShoppingListItem: true,
      ),
      ListItem(
        description: "carrots",
        amount: 1,
        unit: "bag",
        isShoppingListItem: true,
      ),
      ListItem(
        description: "cheese",
        amount: 1,
        unit: "block",
        isShoppingListItem: true,
      ),
      ListItem(
        description: "butter",
        amount: 1,
        unit: "stick",
        isShoppingListItem: true,
      ),
      ListItem(
        description: "onions",
        amount: 3,
        unit: "",
        isShoppingListItem: true,
      ),
      ListItem(
        description: "coffee",
        amount: 1,
        unit: "bag",
        isShoppingListItem: true,
      ),
      ListItem(
        description: "pasta",
        amount: 2,
        unit: "packs",
        isShoppingListItem: true,
      ),
      ListItem(
        description: "cereal",
        amount: 1,
        unit: "box",
        isShoppingListItem: true,
      ),
      ListItem(
        description: "dish soap",
        amount: 1,
        unit: "bottle",
        isShoppingListItem: true,
      ),
      ListItem(
        description: "toilet paper",
        amount: 6,
        unit: "rolls",
        isShoppingListItem: true,
      ),
      ListItem(
        description: "tomatoes",
        amount: 5,
        unit: "",
        isShoppingListItem: true,
      ),
      ListItem(
        description: "yogurt",
        amount: 4,
        unit: "cups",
        isShoppingListItem: true,
      ),
    ],
  ),
  ShoppingList(
    title: "Sesame Chicken",
    imgUrl:
        "https://www.dinneratthezoo.com/wp-content/uploads/2015/04/sesame-chicken-2.jpg",
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
