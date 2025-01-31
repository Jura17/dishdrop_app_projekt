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
            RecipeInfoColumn(widget: widget),
            SizedBox(height: 20),
            if (widget.recipe.tags.isNotEmpty)
              TagsContainer(recipe: widget.recipe),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: FilledButton(
                style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor),
                onPressed: () {},
                child: Text("Jump to recipe"),
              ),
            ),
            SizedBox(height: 20),
            Text("Description",
                style: Theme.of(context).textTheme.headlineMedium),
            Text(
              widget.recipe.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class RecipeInfoColumn extends StatelessWidget {
  const RecipeInfoColumn({
    super.key,
    required this.widget,
  });

  final RecipeDetailsScreen widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4,
      children: [
        Row(
          spacing: 4,
          children: [
            Icon(
              Icons.timer_outlined,
              size: 30,
            ),
            Text(
              "${widget.recipe.prepTime + widget.recipe.cookTime} min (Prep: ${widget.recipe.prepTime} min, Cook: ${widget.recipe.cookTime} min)",
              style: Theme.of(context).textTheme.bodyLarge,
            )
          ],
        ),
        Row(
          spacing: 4,
          children: [
            Icon(
              Icons.workspace_premium_sharp,
              size: 30,
            ),
            Text(
              widget.recipe.difficulty,
              style: Theme.of(context).textTheme.bodyLarge,
            )
          ],
        ),
        Row(
          spacing: 4,
          children: [
            Icon(
              Icons.check_circle_outline_outlined,
              size: 30,
            ),
            RichText(
              text: TextSpan(
                text: "Cooked ",
                style: Theme.of(context).textTheme.bodyLarge,
                children: [
                  TextSpan(
                    text: "${widget.recipe.timesCooked}",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: " times")
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}

class TagsContainer extends StatelessWidget {
  const TagsContainer({super.key, required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    String tagString = "";
    for (int i = 0; i < recipe.tags.length; i++) {
      tagString = tagString + recipe.tags[i];
      if (i < recipe.tags.length) tagString = "$tagString, ";
    }

    return Column(
      children: [
        RichText(
          text: TextSpan(
            text: "Tags: ",
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                text: tagString,
                style: Theme.of(context).textTheme.bodyLarge,
              )
            ],
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
