import 'package:flutter/material.dart';

class TagsInputSection extends StatefulWidget {
  const TagsInputSection({
    super.key,
    required this.complexInputValues,
    required this.tagsCtrl,
    required this.updateTagsList,
  });

  final Map<String, dynamic> complexInputValues;
  final TextEditingController tagsCtrl;
  final Function updateTagsList;

  @override
  State<TagsInputSection> createState() => _TagsInputSectionState();
}

class _TagsInputSectionState extends State<TagsInputSection> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            onFieldSubmitted: (value) => widget.updateTagsList(),
            controller: widget.tagsCtrl,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Tags",
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            widget.updateTagsList();
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
