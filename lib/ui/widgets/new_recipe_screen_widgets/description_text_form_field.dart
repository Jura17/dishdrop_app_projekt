import 'package:flutter/material.dart';

class DescriptionTextFormField extends StatelessWidget {
  const DescriptionTextFormField({
    super.key,
    required this.descCtrl,
  });

  final TextEditingController descCtrl;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: null,
      maxLength: 1000,
      validator: (value) {
        if ((value?.length ?? 0) > 1000) {
          return "The description is limited to 1000 characters.";
        }

        return null;
      },
      controller: descCtrl,
      decoration: const InputDecoration(
        hintText: "Description",
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      ),
    );
  }
}
