import 'package:dishdrop_app_projekt/data/models/cooking_direction.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_form_screen_widgets/cooking_direction_row_dynamic.dart';
import 'package:flutter/material.dart';

class CookingDirectionsListView extends StatefulWidget {
  const CookingDirectionsListView({
    super.key,
    required this.complexInputValues,
    required this.removeFromCookingDirectionsListFunc,
  });

  final Map<String, dynamic> complexInputValues;
  final Function removeFromCookingDirectionsListFunc;

  @override
  State<CookingDirectionsListView> createState() => _CookingDirectionsListViewState();
}

class _CookingDirectionsListViewState extends State<CookingDirectionsListView> {
  @override
  Widget build(BuildContext context) {
    int counter = 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.complexInputValues["directions"].map<Widget>(
        (cookingDirection) {
          counter++;

          return Container(
            key: Key(cookingDirection.tempID),
            child: CookingDirectionRowDynamic(
              cookingDirection: cookingDirection,
              removeFromCookingDirectionsListFunc: widget.removeFromCookingDirectionsListFunc,
              rowIndex: counter,
            ),
          );
        },
      ).toList(),
    );
  }
}
