import 'package:flutter/material.dart';

class DescriptionTextFormField extends StatelessWidget {
  const DescriptionTextFormField({
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
      controller: _allTextFormCtrl["descCtrl"],
      onChanged: (value) => _userInputValues["description"] = value,
      decoration: const InputDecoration(
        hintText: "Description",
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(vertical: 50, horizontal: 16),
      ),
    );
  }
}
