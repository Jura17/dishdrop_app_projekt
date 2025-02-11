import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PrepTimeTextFormField extends StatelessWidget {
  const PrepTimeTextFormField({
    super.key,
    required this.prepTimeCtrl,
    // required this.userInputValues,
  });

  final TextEditingController prepTimeCtrl;
  // final Map<String, dynamic> userInputValues;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: prepTimeCtrl,
      // onChanged: (value) => userInputValues["prepTime"] = int.tryParse(value),
      decoration: const InputDecoration(
          filled: true,
          fillColor: AppColors.lightGrey,
          border: OutlineInputBorder(),
          hintText: "Prep Time"),
    );
  }
}

// import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
// import 'package:flutter/material.dart';

// class PrepTimeTextFormField extends StatelessWidget {
//   const PrepTimeTextFormField({
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
//       controller: _allTextFormCtrl["prepTimeCtrl"],
//       onChanged: (value) => _userInputValues["prepTime"] = int.tryParse(value),
//       decoration: const InputDecoration(
//           filled: true,
//           fillColor: AppColors.lightGrey,
//           border: OutlineInputBorder(),
//           hintText: "Prep Time"),
//     );
//   }
// }
