import 'package:flutter/material.dart';

class CookingTimeTextFormField extends StatelessWidget {
  const CookingTimeTextFormField({
    super.key,
    required this.cookingTimeCtrl,
  });

  final TextEditingController cookingTimeCtrl;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: cookingTimeCtrl,
      decoration: const InputDecoration(
          border: OutlineInputBorder(), hintText: "Cooking Time"),
    );
  }
}

// import 'package:flutter/material.dart';

// class CookingTimeTextFormField extends StatelessWidget {
//   const CookingTimeTextFormField({
//     super.key,
//     required Map<String, TextEditingController> allTextFormCtrl,
//     required Map<String, dynamic> userInputValues,
//   })  : _allTextFormCtrl = allTextFormCtrl,
//         _userInputValues = userInputValues;

//   final Map<String, TextEditingController> _allTextFormCtrl;
//   final Map<String, dynamic> _userInputValues;

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: _allTextFormCtrl["cookingTimeCtrl"],
//       onChanged: (value) =>
//           _userInputValues["cookingTime"] = int.tryParse(value),
//       decoration: const InputDecoration(
//           border: OutlineInputBorder(), hintText: "Cooking Time"),
//     );
//   }
// }
