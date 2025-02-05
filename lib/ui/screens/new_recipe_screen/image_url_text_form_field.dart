import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ImageUrlTextFormField extends StatelessWidget {
  const ImageUrlTextFormField({
    super.key,
    required Map<String, TextEditingController> allTextFormCtrl,
    required Map<String, dynamic> userInputValues,
  })  : _allTextFormCtrl = allTextFormCtrl,
        _userInputValues = userInputValues;

  final Map<String, TextEditingController> _allTextFormCtrl;
  final Map<String, dynamic> _userInputValues;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _allTextFormCtrl["imgUrlCtrl"],
      onChanged: (value) => _userInputValues["images"]["titleImg"] = value,
      decoration: const InputDecoration(
        filled: true,
        fillColor: AppColors.lightGrey,
        hintText: "Image-URL",
        border: OutlineInputBorder(),
      ),
    );
  }
}
