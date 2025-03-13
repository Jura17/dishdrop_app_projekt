import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class IngredientInputSection extends StatefulWidget {
  const IngredientInputSection({
    super.key,
    required this.allTextFormCtrl,
    required this.complexInputValues,
    required this.updateIngredientList,
  });

  final Map<String, TextEditingController> allTextFormCtrl;
  final Map<String, dynamic> complexInputValues;
  final Function updateIngredientList;

  @override
  State<IngredientInputSection> createState() => _IngredientInputSectionState();
}

class _IngredientInputSectionState extends State<IngredientInputSection> {
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
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      validator: (value) {
                        if (value == '') return "Please enter a value";
                        if (int.tryParse(value!) == null)
                          return "Only numerics allowed";
                        if (int.parse(value) < 1)
                          return "Only positives allowed";
                        return null;
                      },
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
