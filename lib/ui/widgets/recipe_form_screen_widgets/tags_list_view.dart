import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:simple_tags/simple_tags.dart';

class TagsListView extends StatelessWidget {
  const TagsListView(
      {super.key,
      required this.complexInputValues,
      required this.removeFromTagsList});

  final Map<String, dynamic> complexInputValues;
  final Function removeFromTagsList;

  @override
  Widget build(BuildContext context) {
    return SimpleTags(
      content: complexInputValues["tags"],
      wrapSpacing: 4,
      wrapRunSpacing: 4,
      onTagPress: (tag) {
        removeFromTagsList(tag);
      },
      tagContainerPadding: EdgeInsets.all(6),
      tagTextStyle: TextStyle(color: AppColors.primary),
      tagIcon: Icon(Icons.clear, size: 15),
      tagContainerDecoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(139, 139, 142, 0.16),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(1.75, 3.5),
          )
        ],
      ),
    );
  }
}
