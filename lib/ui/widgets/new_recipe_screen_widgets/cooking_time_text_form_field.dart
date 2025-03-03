import 'package:flutter/material.dart';

class CookingTimeTextFormField extends StatelessWidget {
  const CookingTimeTextFormField({
    super.key,
    required this.cookingTimeCtrl,
  });

  final TextEditingController cookingTimeCtrl;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == '') return "Please enter a value";
        if (int.tryParse(value!) == null) return "Only numerics allowed";
        if (int.parse(value) < 1) return "Only positives allowed";
      },
      controller: cookingTimeCtrl,
      decoration: const InputDecoration(
          border: OutlineInputBorder(), hintText: "Cooking Time"),
    );
  }
}
