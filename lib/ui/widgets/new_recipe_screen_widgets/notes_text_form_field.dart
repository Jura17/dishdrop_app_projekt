import 'package:flutter/material.dart';

class NotesTextFormField extends StatelessWidget {
  const NotesTextFormField({
    super.key,
    required this.notesCtrl,
  });

  final TextEditingController notesCtrl;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: null,
      maxLength: 1000,
      validator: (value) {
        if ((value?.length ?? 0) > 1000) {
          return "Notes are limited to 1000 characters.";
        }
        return null;
      },
      controller: notesCtrl,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Notes",
        contentPadding: EdgeInsets.symmetric(vertical: 50, horizontal: 16),
      ),
    );
  }
}
