import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:dishdrop_app_projekt/core/utils/check_amount_and_convert.dart';
import 'package:flutter/material.dart';

class RecipeFormIngredientListView extends StatefulWidget {
  const RecipeFormIngredientListView({
    super.key,
    required this.complexInputValues,
  });

  final Map<String, dynamic> complexInputValues;

  @override
  State<RecipeFormIngredientListView> createState() =>
      _RecipeFormIngredientListViewState();
}

class _RecipeFormIngredientListViewState
    extends State<RecipeFormIngredientListView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.complexInputValues["ingredients"].length,
          (index) {
        return Container(
          decoration: BoxDecoration(
              color: index.isEven ? AppColors.lightGrey : Colors.white),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${checkAmountAndConvert(widget.complexInputValues["ingredients"][index].amount)} ${widget.complexInputValues["ingredients"][index].unit?.toString() ?? ''}",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                // Text(
                //   "${_userInputValues["ingredients"][index].amount?.toString() ?? ''} ${_userInputValues["ingredients"][index].unit?.toString() ?? ''}",
                //   style: Theme.of(context).textTheme.bodyLarge,
                // ),

                Expanded(
                  child: Text(
                    widget.complexInputValues["ingredients"][index].description,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.right,
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
