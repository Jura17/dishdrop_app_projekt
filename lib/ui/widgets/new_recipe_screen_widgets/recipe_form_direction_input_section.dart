import 'package:flutter/material.dart';

class RecipeFormDirectionInputSection extends StatefulWidget {
  const RecipeFormDirectionInputSection({
    super.key,
    required this.complexInputValues,
    required this.allTextFormCtrl,
    required this.updateDirectionList,
  });

  final Map<String, dynamic> complexInputValues;
  final Map<String, TextEditingController> allTextFormCtrl;
  final Function updateDirectionList;

  @override
  State<RecipeFormDirectionInputSection> createState() =>
      _RecipeFormDirectionInputSectionState();
}

class _RecipeFormDirectionInputSectionState
    extends State<RecipeFormDirectionInputSection> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: widget.allTextFormCtrl["directionDescCtrl"],
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add cooking directions"),
          ),
        ),
        IconButton(
            onPressed: () {
              widget.updateDirectionList();
            },
            icon: Icon(
              Icons.add_box_outlined,
              size: 50,
            ))
      ],
    );
  }
}
