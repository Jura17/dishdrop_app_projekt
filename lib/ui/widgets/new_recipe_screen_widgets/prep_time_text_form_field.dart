import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PrepTimeTextFormField extends StatelessWidget {
  const PrepTimeTextFormField({
    super.key,
    required this.prepTimeCtrl,
  });

  final TextEditingController prepTimeCtrl;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == '') return "Please enter a value";
        if (int.tryParse(value!) == null) return "Only numerics allowed";
        if (int.parse(value) < 1) return "Only positives allowed";
      },
      controller: prepTimeCtrl,
      decoration: const InputDecoration(
          filled: true,
          fillColor: AppColors.lightGrey,
          border: OutlineInputBorder(),
          hintText: "Prep Time"),
    );
  }
}
