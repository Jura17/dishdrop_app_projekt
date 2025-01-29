import 'package:flutter/material.dart';

class RecipesGridView extends StatelessWidget {
  final String category;
  const RecipesGridView({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              Text(category, style: Theme.of(context).textTheme.headlineLarge),
        ),
        body: GridView.count(
          crossAxisCount: 2,
          children: [],
        ));
  }
}
