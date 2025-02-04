import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ShoppingListSegmentButton extends StatefulWidget {
  const ShoppingListSegmentButton({
    super.key,
  });

  @override
  State<ShoppingListSegmentButton> createState() =>
      _ShoppingListSegmentButtonState();
}

class _ShoppingListSegmentButtonState extends State<ShoppingListSegmentButton> {
  Set<String> _selected = {"allPurpose"};

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<String>(
      style: SegmentedButton.styleFrom(
        foregroundColor: AppColors.primary,
        backgroundColor: AppColors.lightGreen,
        selectedBackgroundColor: AppColors.primary,
        selectedForegroundColor: Colors.white,
      ),
      emptySelectionAllowed: false,
      showSelectedIcon: false,
      multiSelectionEnabled: false,
      segments: <ButtonSegment<String>>[
        ButtonSegment(value: "allPurpose", label: Text("All-Purpose List")),
        ButtonSegment(value: "byRecipe", label: Text("By Recipe")),
      ],
      selected: _selected,
      onSelectionChanged: updateSelected,
    );
  }

  void updateSelected(Set<String> newSelection) {
    setState(() {
      _selected = newSelection;
    });
  }
}
