import 'package:flutter/material.dart';

class CategoryDropdownMenu extends StatefulWidget {
  CategoryDropdownMenu({
    super.key,
    required this.categoryCtrl,
    required this.showError,
  });

  final TextEditingController categoryCtrl;
  bool showError;

  @override
  State<CategoryDropdownMenu> createState() => _CategoryDropdownMenuState();
}

class _CategoryDropdownMenuState extends State<CategoryDropdownMenu> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownMenu(
          onSelected: (value) {
            setState(() {
              widget.showError = false;
            });
          },
          controller: widget.categoryCtrl,
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(),
          ),
          width: double.infinity,
          dropdownMenuEntries: [
            DropdownMenuEntry(value: "Appetizers", label: "Appetizers"),
            DropdownMenuEntry(value: "Main Courses", label: "Main Courses"),
            DropdownMenuEntry(value: "Side Dishes", label: "Side Dishes"),
            DropdownMenuEntry(value: "Salads", label: "Salads"),
            DropdownMenuEntry(value: "Sweet Stuff", label: "Sweet Stuff"),
            DropdownMenuEntry(value: "Drinks", label: "Drinks")
          ],
          hintText: "Select category",
        ),
        SizedBox(height: 10),
        if (widget.showError)
          Text(
            "Please select a category",
            style: TextStyle(color: Colors.red),
          ),
        SizedBox(height: 10),
      ],
    );
  }
}
