import 'package:dishdrop_app_projekt/data/repositories/mock_database.dart';
import 'package:flutter/material.dart';

class RecipesGridView extends StatelessWidget {
  final String category;
  RecipesGridView({super.key, required this.category});
  MockDatabase mockDatabase = MockDatabase();

  @override
  Widget build(BuildContext context) {
    var allRecipes = mockDatabase.getAllRecipes();

    return Scaffold(
      appBar: AppBar(
        title: Text(category, style: Theme.of(context).textTheme.headlineLarge),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [],
      ),
    );
  }
}
