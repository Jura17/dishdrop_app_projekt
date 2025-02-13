import 'package:flutter/material.dart';

class CategoryDropdownMenu extends StatelessWidget {
  const CategoryDropdownMenu({
    super.key,
    required this.categoryCtrl,
  });

  final TextEditingController categoryCtrl;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      // TODO: DropdownMenu has no validator property as of Feb 2025. Needs a custom check.
      controller: categoryCtrl,
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
    );
  }
}

// import 'package:flutter/material.dart';

// class CategoryDropdownMenu extends StatelessWidget {
//   const CategoryDropdownMenu({
//     super.key,
//     required Map<String, TextEditingController> allTextFormCtrl,
//     required Map<String, dynamic> userInputValues,
//   })  : _allTextFormCtrl = allTextFormCtrl,
//         _userInputValues = userInputValues;

//   final Map<String, TextEditingController> _allTextFormCtrl;
//   final Map<String, dynamic> _userInputValues;

//   @override
//   Widget build(BuildContext context) {
//     return DropdownMenu(
//       controller: _allTextFormCtrl["categoryCtrl"],
//       onSelected: (value) => _userInputValues["category"] = value,
//       inputDecorationTheme: InputDecorationTheme(
//         border: OutlineInputBorder(),
//       ),
//       width: double.infinity,
//       dropdownMenuEntries: [
//         DropdownMenuEntry(value: "Appetizers", label: "Appetizers"),
//         DropdownMenuEntry(value: "Main Courses", label: "Main Courses"),
//         DropdownMenuEntry(value: "Side Dishes", label: "Side Dishes"),
//         DropdownMenuEntry(value: "Salads", label: "Salads"),
//         DropdownMenuEntry(value: "Sweet Stuff", label: "Sweet Stuff"),
//         DropdownMenuEntry(value: "Drinks", label: "Drinks")
//       ],
//       hintText: "Select category",
//     );
//   }
// }
