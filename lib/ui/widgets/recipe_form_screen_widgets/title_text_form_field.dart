import 'package:flutter/material.dart';

class TitleTextFormField extends StatelessWidget {
  const TitleTextFormField({super.key, required this.titleCtrl});

  final TextEditingController titleCtrl;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        String? title = value ?? '';
        if (title == '') {
          return "Please enter a title for your recipe.";
        }

        return null;
      },
      autovalidateMode: AutovalidateMode.onUnfocus,
      controller: titleCtrl,
      decoration: const InputDecoration(
        hintText: "Title",
        border: OutlineInputBorder(),
      ),
    );
  }
}
