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
                maxLength: 40,
                controller: widget.allTextFormCtrl["ingredientDescCtrl"],
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Ingredient description",
                  counterText: "",
                ),
              ),
              Row(
                spacing: 10,
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      validator: (value) {
                        if (value == '') return null;
                        double? amount = double.tryParse(value ?? '');
                        if (amount == null) return "Only numerics allowed";
                        if (amount < 0) return "Only positives allowed";
                        return null;
                      },
                      maxLength: 6,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: widget.allTextFormCtrl["ingredientAmountCtrl"],
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: AppColors.lightGrey,
                        border: OutlineInputBorder(),
                        hintText: "Amount",
                        counterText: "",
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      maxLength: 10,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: widget.allTextFormCtrl["ingredientUnitCtrl"],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Unit",
                        counterText: "",
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                "You can enter fractional amounts like 1½ as 1.5",
                style: Theme.of(context).textTheme.labelMedium?.copyWith(fontStyle: FontStyle.italic),
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
