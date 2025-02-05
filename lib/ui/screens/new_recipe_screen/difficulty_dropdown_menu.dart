import 'package:flutter/material.dart';

class DifficultyDropdownMenu extends StatelessWidget {
  const DifficultyDropdownMenu({
    super.key,
    required Map<String, TextEditingController> allTextFormCtrl,
    required Map<String, dynamic> userInputValues,
  })  : _allTextFormCtrl = allTextFormCtrl,
        _userInputValues = userInputValues;

  final Map<String, TextEditingController> _allTextFormCtrl;
  final Map<String, dynamic> _userInputValues;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      controller: _allTextFormCtrl["difficultyCtrl"],
      onSelected: (value) => _userInputValues["difficulty"] = value,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
      width: double.infinity,
      dropdownMenuEntries: [
        DropdownMenuEntry(value: "Simple", label: "Simple"),
        DropdownMenuEntry(value: "Not Too Tricky", label: "Not Too Tricky"),
        DropdownMenuEntry(value: "Impressive", label: "Impressive"),
      ],
      hintText: "Select difficulty",
    );
  }
}
