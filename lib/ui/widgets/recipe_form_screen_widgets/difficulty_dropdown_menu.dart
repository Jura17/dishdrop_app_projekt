import 'package:flutter/material.dart';

class DifficultyDropdownMenu extends StatefulWidget {
  DifficultyDropdownMenu({
    super.key,
    required this.difficultyCtrl,
    required this.showError,
  });

  final TextEditingController difficultyCtrl;
  bool showError;

  @override
  State<DifficultyDropdownMenu> createState() => _DifficultyDropdownMenuState();
}

class _DifficultyDropdownMenuState extends State<DifficultyDropdownMenu> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownMenu(
          initialSelection: widget.difficultyCtrl.text,
          onSelected: (value) {
            setState(() {
              widget.showError = false;
            });
          },
          controller: widget.difficultyCtrl,
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
        ),
        SizedBox(height: 10),
        if (widget.showError)
          Text(
            "Please select a difficulty",
            style: TextStyle(color: Colors.red),
          ),
        SizedBox(height: 10),
      ],
    );
  }
}
