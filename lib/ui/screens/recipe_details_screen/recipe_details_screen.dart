import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/repositories/mock_database.dart';
import 'package:dishdrop_app_projekt/ui/screens/recipe_details_screen/description_section.dart';
import 'package:dishdrop_app_projekt/ui/screens/recipe_details_screen/directions_section.dart';
import 'package:dishdrop_app_projekt/ui/screens/recipe_details_screen/ingredients_section.dart';
import 'package:dishdrop_app_projekt/ui/screens/recipe_details_screen/quick_info_section.dart';
import 'package:dishdrop_app_projekt/ui/screens/recipe_details_screen/tags_section.dart';

import 'package:dishdrop_app_projekt/ui/widgets/like_button.dart';
import 'package:dishdrop_app_projekt/ui/widgets/custom_filled_icon_button.dart';

import 'package:flutter/material.dart';

class RecipeDetailsScreen extends StatefulWidget {
  const RecipeDetailsScreen({
    super.key,
    required this.recipe,
    required this.db,
  });
  final Recipe recipe;
  final MockDatabase db;

  @override
  State<RecipeDetailsScreen> createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  double defaultSpacing = 20;

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
                  recipe: widget.recipe,
                )
              ],
            ),
            SizedBox(height: defaultSpacing),
            QuickInfoSection(widget: widget),
            SizedBox(height: defaultSpacing),
            if (widget.recipe.tags.isNotEmpty)
              TagsSection(recipe: widget.recipe),
            SizedBox(height: defaultSpacing),
            Align(
              alignment: Alignment.centerRight,
              child: FilledButton(
                onPressed: () {},
                // TODO: find a way to get the index of the ingredient section and scroll to its position
                child: Text("Jump to recipe"),
              ),
            ),
            SizedBox(height: defaultSpacing),
            if (widget.recipe.description.isNotEmpty)
              DescriptionSection(recipe: widget.recipe),
            SizedBox(height: defaultSpacing),
            if (widget.recipe.directions.isNotEmpty)
              DirectionsSection(recipe: widget.recipe),
            SizedBox(height: defaultSpacing),
            if (widget.recipe.ingredients.isNotEmpty)
              IngredientsSection(recipe: widget.recipe),
            SizedBox(height: 40),
            RichText(
              text: TextSpan(
                text: "You have cooked this dish ",
                style: Theme.of(context).textTheme.bodyLarge,
                children: [
                  TextSpan(
                    text: "${widget.recipe.timesCooked}",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                      text:
                          " times so far.\nTap the button below when you're done!")
                ],
              ),
            ),
            SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 30,
              children: [
                FilledButton.icon(
                  icon: Icon(Icons.check),
                  onPressed: () {
                    setState(() {
                      widget.recipe.timesCooked++;
                    });
                  },
                  label: Text("I'm done cooking!"),
                ),
                TextButton.icon(
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.red, iconColor: Colors.red),
                  onPressed: () {
                    int id = widget.db.getAllRecipes().indexOf(widget.recipe);
                    setState(() {
                      widget.db.removeRecipe(id);
                    });
                    Navigator.of(context).pop();
                  },
                  label: Text("Remove recipe"),
                  icon: Icon(
                    Icons.delete,
                    size: 30,
                  ),
                ),
              ],
            ),
            SizedBox(height: 130),
          ],
        ),
      ),
      floatingActionButton: Row(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomFilledIconButton(
            text: "Edit Recipe",
            iconData: Icons.edit,
            db: widget.db,
          ),
          CustomFilledIconButton(
            text: "Add Recipe",
            iconData: Icons.add_box_outlined,
            db: widget.db,
          ),
        ],
      ),
    );
  }
}
