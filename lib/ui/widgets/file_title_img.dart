import 'dart:io';

import 'package:flutter/material.dart';

class FileTitleImg extends StatelessWidget {
  const FileTitleImg({
    super.key,
    required this.imgPath,
  });

  final String imgPath;

  @override
  Widget build(BuildContext context) {
    return Image.file(
      errorBuilder: (context, error, stackTrace) {
        return Center(
          child: Text(
            "Error loading image",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        );
      },
      File(imgPath),
      fit: BoxFit.cover,
    );
  }
}
