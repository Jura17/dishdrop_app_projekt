import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:dishdrop_app_projekt/data/provider/shopping_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllPurposeListInputSection extends StatefulWidget {
  const AllPurposeListInputSection({
    super.key,
    required this.allTextControllers,
    required this.updateListFunction,
    required this.formKey,
  });

  final Map<String, TextEditingController> allTextControllers;
  final Function updateListFunction;
  final GlobalKey<FormState> formKey;

  @override
  State<AllPurposeListInputSection> createState() => _AllPurposeListInputSectionState();
}

class _AllPurposeListInputSectionState extends State<AllPurposeListInputSection> {
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
                maxLength: 60,
                controller: widget.allTextControllers["itemDescCtrl"],
                decoration: const InputDecoration(border: OutlineInputBorder(), hintText: "Ingredient description"),
              ),
              Row(
                spacing: 10,
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      validator: (value) {
                        if (value == '') return null;
                        if (double.tryParse(value!) == null) return "Only numerics allowed";
                        if (double.parse(value) < 1) return "Only positives allowed";
                        return null;
                      },
                      controller: widget.allTextControllers["itemAmountCtrl"],
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
                      controller: widget.allTextControllers["itemUnitCtrl"],
                      decoration: const InputDecoration(border: OutlineInputBorder(), hintText: "Unit"),
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
            if (widget.formKey.currentState!.validate()) {
              widget.updateListFunction();
              context.read<ShoppingListNotifier>().loadAllPurposeShoppingList();
            }
          },
          icon: Icon(
            Icons.add_box_outlined,
            size: 35,
          ),
        )
      ],
    );
  }
}
