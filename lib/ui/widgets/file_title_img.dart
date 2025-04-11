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
    print('imgpath: $imgPath');
    return Image.file(
      errorBuilder: (context, error, stackTrace) {
        print(error);
        return Center(
          child: Text(
            "404",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        );
      },
      File(imgPath),
      fit: BoxFit.cover,
    );
  }
}
