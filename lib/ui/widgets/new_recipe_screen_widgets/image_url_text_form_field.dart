import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ImageUrlTextFormField extends StatelessWidget {
  const ImageUrlTextFormField({
    super.key,
    required this.imgUrlCtrl,
  });

  final TextEditingController imgUrlCtrl;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: imgUrlCtrl,
      // onChanged: (value) => userInputValues["images"]["titleImg"] = value,
      decoration: const InputDecoration(
        filled: true,
        fillColor: AppColors.lightGrey,
        hintText: "Image-URL",
        border: OutlineInputBorder(),
      ),
    );
  }
}
