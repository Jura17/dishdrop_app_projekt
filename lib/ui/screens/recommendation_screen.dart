import 'package:dishdrop_app_projekt/data/repositories/mock_database.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recommendation_button.dart';
import 'package:flutter/material.dart';

class RecommendationScreen extends StatefulWidget {
  const RecommendationScreen({super.key, required this.db});

  final MockDatabase db;

  @override
  State<RecommendationScreen> createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          child: Text("Recommend Me Something!",
              style: Theme.of(context).textTheme.headlineLarge),
        ),
      ),
      body: Center(
        child: RecommendationButton(
          db: widget.db,
          allRecipes: widget.db.getAllRecipes(),
        ),
      ),
    );
  }
}
