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
        int? time = int.tryParse(value ?? '');
        if (time == null) return "Numeric values only";
        if (time < 0) return "Positive values only";
        return null;
      },
      maxLength: 4,
      keyboardType: TextInputType.numberWithOptions(decimal: false),
      autovalidateMode: AutovalidateMode.onUnfocus,
      controller: cookingTimeCtrl,
      decoration: const InputDecoration(border: OutlineInputBorder(), hintText: "Cooking Time", counterText: ""),
    );
  }
}
