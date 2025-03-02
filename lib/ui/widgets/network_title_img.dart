import 'package:flutter/material.dart';

class NetworkTitleImg extends StatelessWidget {
  const NetworkTitleImg({
    super.key,
    required this.imgPath,
  });

  final String imgPath;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      errorBuilder: (context, error, stackTrace) => Center(
          child: Text(
        "404",
        style: Theme.of(context).textTheme.headlineLarge,
      )),
      imgPath,
      fit: BoxFit.cover,
    );
  }
}
