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
        int? time = int.tryParse(value ?? '');
        if (time == null) return "Numeric values only";
        if (time < 0) return "Positives values only";
        return null;
      },
      maxLength: 4,
      autovalidateMode: AutovalidateMode.onUnfocus,
      keyboardType: TextInputType.numberWithOptions(decimal: false),
      controller: prepTimeCtrl,
      decoration: const InputDecoration(
          filled: true,
          fillColor: AppColors.lightGrey,
          border: OutlineInputBorder(),
          hintText: "Prep Time",
          counterText: ""),
    );
  }
}
