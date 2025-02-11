import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class RecipeFormIngredientInputSection extends StatefulWidget {
  const RecipeFormIngredientInputSection({
    super.key,
    required this.allTextFormCtrl,
    required this.complexInputValues,
    required this.updateIngredientList,
  });

  final Map<String, TextEditingController> allTextFormCtrl;
  final Map<String, dynamic> complexInputValues;
  final Function updateIngredientList;

  @override
  State<RecipeFormIngredientInputSection> createState() =>
      _RecipeFormIngredientInputSectionState();
}

class _RecipeFormIngredientInputSectionState
    extends State<RecipeFormIngredientInputSection> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              TextFormField(
                controller: widget.allTextFormCtrl["ingredientDescCtrl"],
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Ingredient description"),
              ),
              Row(
                spacing: 10,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller:
                          widget.allTextFormCtrl["ingredientAmountCtrl"],
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: AppColors.lightGrey,
                        border: OutlineInputBorder(),
                        hintText: "Amount",
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: widget.allTextFormCtrl["ingredientUnitCtrl"],
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: "Unit"),
                    ),
                  ),
                ],
              ),
              Text(
                "You can enter fractional amounts like 1½ as 1.5",
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(fontStyle: FontStyle.italic),
              )
            ],
          ),
        ),
        IconButton(
          onPressed: () {
            widget.updateIngredientList();
          },
          icon: Icon(
            Icons.add_box_outlined,
            size: 50,
          ),
        )
      ],
    );
  }
}
