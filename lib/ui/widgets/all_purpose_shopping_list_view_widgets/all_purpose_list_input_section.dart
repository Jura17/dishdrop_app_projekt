import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AllPurposeListInputSection extends StatefulWidget {
  const AllPurposeListInputSection({
    super.key,
    required this.allTextControllers,
    required this.updateListFunction,
  });

  final Map<String, TextEditingController> allTextControllers;

  final Function updateListFunction;

  @override
  State<AllPurposeListInputSection> createState() =>
      _AllPurposeListInputSectionState();
}

class _AllPurposeListInputSectionState
    extends State<AllPurposeListInputSection> {
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
                controller: widget.allTextControllers["itemDescCtrl"],
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Ingredient description"),
              ),
              Row(
                spacing: 10,
                children: [
                  Expanded(
                    child: TextFormField(
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
            widget.updateListFunction();
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
