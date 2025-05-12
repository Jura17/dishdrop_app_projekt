import 'package:dishdrop_app_projekt/core/utils/check_and_convert_amount.dart';
import 'package:dishdrop_app_projekt/data/models/list_item.dart';
import 'package:dishdrop_app_projekt/data/provider/shopping_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipeShoppingItemRowDismissable extends StatelessWidget {
  const RecipeShoppingItemRowDismissable({
    super.key,
    required this.shoppingListId,
    required this.servings,
    required this.dismissFunc,
    required this.index,
    required this.shoppingItem,
  });

  final int shoppingListId;
  final int servings;
  final Function dismissFunc;
  final int index;
  final ListItem shoppingItem;

  @override
  Widget build(BuildContext context) {
    final shoppingListProvider = context.watch<ShoppingListNotifier>();

    final double? amount = shoppingItem.amount != null ? shoppingItem.amount! * servings : null;
    List<String> convertedAmount = checkAndconvertAmount(amount);

    return Dismissible(
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        dismissFunc(index);
        shoppingListProvider.removeFromRecipeShoppingList(shoppingListId, shoppingItem.id);
      },
      key: Key(shoppingItem.tempID),
      background: Container(
        alignment: Alignment.centerRight,
        color: Colors.red,
        padding: EdgeInsets.only(right: 20),
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: Row(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Checkbox(
              value: shoppingItem.isDone,
              onChanged: (bool? value) {
                shoppingItem.isDone = value ?? false;
                context.read<ShoppingListNotifier>().updateRecipeShoppingListItem(shoppingListId, shoppingItem);
              }),
          RichText(
            text: TextSpan(
              text: convertedAmount[0],
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    decoration: shoppingItem.isDone ? TextDecoration.lineThrough : null,
                  ),
              children: [
                TextSpan(
                  text: convertedAmount[1],
                  style: TextStyle(
                    decoration: shoppingItem.isDone ? TextDecoration.lineThrough : null,
                    fontFeatures: [FontFeature.fractions()],
                  ),
                ),
                TextSpan(
                  text: " ${shoppingItem.unit ?? ''}",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        decoration: shoppingItem.isDone ? TextDecoration.lineThrough : null,
                      ),
                )
              ],
            ),
          ),
          Expanded(
            child: Text(
              shoppingItem.description,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    decoration: shoppingItem.isDone ? TextDecoration.lineThrough : null,
                  ),
              textAlign: TextAlign.right,
            ),
          )
        ],
      ),
    );
  }
}
