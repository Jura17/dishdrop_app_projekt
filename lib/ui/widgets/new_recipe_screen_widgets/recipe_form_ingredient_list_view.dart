import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';

import 'package:dishdrop_app_projekt/ui/widgets/list_item_row_dynamic.dart';
import 'package:flutter/material.dart';

class RecipeFormIngredientListView extends StatefulWidget {
  const RecipeFormIngredientListView({
    super.key,
    required this.complexInputValues,
    required this.removeFromListFunc,
  });

  final Map<String, dynamic> complexInputValues;
  final Function removeFromListFunc;

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
              child: ListItemRowDynamic(
                amount: widget.complexInputValues["ingredients"][index].amount,
                unit: widget.complexInputValues["ingredients"][index].unit,
                description: widget.complexInputValues["ingredients"][index].description,
                index: index,
                complexInputValues: widget.complexInputValues,
                removeFromListFunc: widget.removeFromListFunc,
              ),
            ),
          );
        },
      ),
    );
  }

  // void updateIngredientList(int index, Map<String, dynamic> complexInputValues) {
  //   setState(() {
  //     complexInputValues["ingredients"].removeAt(index);
  //     // widget.complexInputValues["ingredients"].removeAt(index);
  //   });
  // }
}
