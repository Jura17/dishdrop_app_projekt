import 'package:dishdrop_app_projekt/ui/widgets/new_recipe_screen_widgets/tag_pill.dart';
import 'package:flutter/material.dart';

class TagsListView extends StatelessWidget {
  const TagsListView({
    super.key,
    required this.complexInputValues,
  });

  final Map<String, dynamic> complexInputValues;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: List.generate(complexInputValues["tags"].length, (index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: TagPill(text: complexInputValues["tags"][index]),
        );
      }),
    );
  }
}
