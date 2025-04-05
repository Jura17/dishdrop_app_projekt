import 'package:flutter/material.dart';

class DifficultyDropdownMenu extends StatefulWidget {
  const DifficultyDropdownMenu({
    super.key,
    required this.difficultyCtrl,
    required this.showErrorFunc,
    required this.getErrorStateFunc,
  });

  final TextEditingController difficultyCtrl;
  final Function showErrorFunc;
  final Function getErrorStateFunc;

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
              widget.showErrorFunc(false);
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
        if (widget.getErrorStateFunc())
          Text(
            "Please select a difficulty",
            style: TextStyle(color: Colors.red),
          ),
        SizedBox(height: 10),
      ],
    );
  }
}
