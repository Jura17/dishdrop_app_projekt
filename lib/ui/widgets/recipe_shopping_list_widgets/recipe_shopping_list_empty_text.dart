import 'package:flutter/material.dart';

class RecipeShoppingListEmptyText extends StatelessWidget {
  const RecipeShoppingListEmptyText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          text: "This list is empty right now.\n\nGo to your ",
          style: Theme.of(context).textTheme.headlineMedium,
          children: [
            TextSpan(
              text: "recipes ",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
            ),
            TextSpan(text: "to add some ", style: Theme.of(context).textTheme.headlineMedium),
            TextSpan(
              text: "shopping items!",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            )
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
