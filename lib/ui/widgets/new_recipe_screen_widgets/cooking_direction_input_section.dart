import 'package:flutter/material.dart';

class CookingDirectionInputSection extends StatefulWidget {
  const CookingDirectionInputSection({
    super.key,
    required this.complexInputValues,
    required this.cookingDirectionCtrl,
    required this.addCookingDirectionFunc,
  });

  final Map<String, dynamic> complexInputValues;
  final TextEditingController cookingDirectionCtrl;
  final Function addCookingDirectionFunc;

  @override
  State<CookingDirectionInputSection> createState() => _CookingDirectionInputSectionState();
}

class _CookingDirectionInputSectionState extends State<CookingDirectionInputSection> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            maxLength: 200,
            maxLines: null,
            controller: widget.cookingDirectionCtrl,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Add cooking directions",
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            widget.addCookingDirectionFunc();
          },
          icon: Icon(
            Icons.add_box_outlined,
            size: 50,
          ),
        )
      ],
    );
  }
}
