import 'package:flutter/material.dart';

class NotesTextFormField extends StatelessWidget {
  const NotesTextFormField({
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
      controller: _allTextFormCtrl["notesCtrl"],
      onChanged: (value) => _userInputValues["notes"] = value,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Notes",
        contentPadding: EdgeInsets.symmetric(vertical: 50, horizontal: 16),
      ),
    );
  }
}
