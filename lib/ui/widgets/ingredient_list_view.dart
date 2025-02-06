import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:flutter/material.dart';

class IngredientListView extends StatefulWidget {
  const IngredientListView({super.key, required this.recipe});

  final Recipe recipe;

  @override
  State<IngredientListView> createState() => _IngredientListViewState();
}

class _IngredientListViewState extends State<IngredientListView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: List.generate(
            widget.recipe.ingredients.length,
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
                        "${widget.recipe.ingredients[index].amount?.toString() ?? ''} ${widget.recipe.ingredients[index].unit?.toString() ?? ''}",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Expanded(
                        child: Text(
                          widget.recipe.ingredients[index].description,
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.right,
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
