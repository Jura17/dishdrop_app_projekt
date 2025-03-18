import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';

import 'package:dishdrop_app_projekt/ui/widgets/list_item_row.dart';
import 'package:flutter/material.dart';

class RecipeFormIngredientListView extends StatefulWidget {
  const RecipeFormIngredientListView({
    super.key,
    required this.complexInputValues,
  });

  final Map<String, dynamic> complexInputValues;

  @override
  State<RecipeFormIngredientListView> createState() => _RecipeFormIngredientListViewState();
}

class _RecipeFormIngredientListViewState extends State<RecipeFormIngredientListView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        widget.complexInputValues["ingredients"].length,
        (index) {
          return Container(
            decoration: BoxDecoration(color: index.isEven ? AppColors.lightGrey : Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListItemRow(
                amount: widget.complexInputValues["ingredients"][index].amount,
                unit: widget.complexInputValues["ingredients"][index].unit,
                description: widget.complexInputValues["ingredients"][index].description,
                index: index,
                complexInputValues: widget.complexInputValues,
                updateListFunc: updateIngredientList,
              ),
            ),
          );
        },
      ),
    );
  }

  void updateIngredientList(int index) {
    setState(() {
      widget.complexInputValues["ingredients"].removeAt(index);
    });
  }
}
