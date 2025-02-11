import 'package:flutter/material.dart';

class TagsTextFormField extends StatelessWidget {
  const TagsTextFormField({
    super.key,
    required this.tagsCtrl,
    // required this.userInputValues,
  });

  final TextEditingController tagsCtrl;
  // final Map<String, dynamic> userInputValues;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: tagsCtrl,
      decoration: const InputDecoration(
        hintText: "Tags",
        border: OutlineInputBorder(),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// class TagsTextFormField extends StatelessWidget {
//   const TagsTextFormField({
//     super.key,
//     required Map<String, TextEditingController> allTextFormCtrl,
//   }) : _allTextFormCtrl = allTextFormCtrl;

//   final Map<String, TextEditingController> _allTextFormCtrl;

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: _allTextFormCtrl["tagsCtrl"],
//       decoration: const InputDecoration(
//         hintText: "Tags",
//         border: OutlineInputBorder(),
//       ),
//     );
//   }
// }
