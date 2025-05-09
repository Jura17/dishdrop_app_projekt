import 'package:dishdrop_app_projekt/core/utils/check_and_convert_amount.dart';
import 'package:dishdrop_app_projekt/data/models/list_item.dart';
import 'package:dishdrop_app_projekt/data/provider/shopping_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingItemRowDismissable extends StatelessWidget {
  const ShoppingItemRowDismissable({
    super.key,
    required this.shoppingListId,
    required this.amount,
    required this.unit,
    required this.description,
    required this.dismissItem,
    required this.index,
    required this.shoppingItem,
  });

  final int shoppingListId;
  final double? amount;
  final String? unit;
  final String description;
  final Function dismissItem;
  final int index;
  final ListItem shoppingItem;

  @override
  Widget build(BuildContext context) {
    final shoppingListProvider = context.watch<ShoppingListNotifier>();
    List<String> convertedAmount = checkAndconvertAmount(amount);

    return Dismissible(
      onDismissed: (direction) {
        dismissItem(index);
        shoppingListProvider.removeFromRecipeShoppingList(shoppingListId, shoppingItem.id);
      },
      key: Key(shoppingItem.tempID),
      background: Container(
        color: Colors.red,
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
              style: Theme.of(context).textTheme.bodyLarge,
              children: [
                TextSpan(
                  text: convertedAmount[1],
                  style: TextStyle(
                    fontFeatures: [FontFeature.fractions()],
                  ),
                ),
                TextSpan(
                  text: " ${unit ?? ''}",
                  style: Theme.of(context).textTheme.bodyLarge,
                )
              ],
            ),
          ),
          Expanded(
            child: Text(
              description,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
