import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/ui/widgets/like_button.dart';
import 'package:flutter/material.dart';

class RecipeDetailsScreen extends StatefulWidget {
  const RecipeDetailsScreen({super.key, required this.recipe});
  final Recipe recipe;

  @override
  State<RecipeDetailsScreen> createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          child: Text(widget.recipe.title,
              style: Theme.of(context).textTheme.headlineLarge),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.dishDropBlack),
                  ),
                  height: 300,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      widget.recipe.images["titleImg"],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                LikeButton(
                  top: 20,
                  right: 20,
                  width: 60,
                  height: 60,
                  iconSize: 40,
                  recipe: widget.recipe,
                )
              ],
            ),
            SizedBox(height: 20),
            Text(widget.recipe.description),
            SizedBox(height: 20),
            Text("Cooked ${widget.recipe.timesCooked.toString()} times"),
          ],
        ),
      ),
    );
  }
}
