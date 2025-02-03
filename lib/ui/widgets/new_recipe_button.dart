import 'package:dishdrop_app_projekt/ui/screens/new_recipe_screen.dart';
import 'package:flutter/material.dart';

class NewRecipeButton extends StatelessWidget {
  const NewRecipeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => NewRecipeScreen()));
      },
      label: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(
            Icons.add_box_outlined,
            color: Theme.of(context).primaryColor,
            size: 28,
          ),
          Text(
            "New Recipe",
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(color: Theme.of(context).primaryColor),
          )
        ],
      ),
    );
  }
}
