import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/provider/recipe_form_notifier.dart';
import 'package:dishdrop_app_projekt/data/provider/recipe_notifier.dart';

import 'package:dishdrop_app_projekt/ui/screens/recipe_form_screen.dart';

import 'package:dishdrop_app_projekt/ui/widgets/custom_filled_icon_button.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_card_widgets/recipe_card.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_search/custom_search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipeGridView extends StatefulWidget {
  const RecipeGridView({
    super.key,
    required this.category,
  });
  final String category;

  @override
  State<RecipeGridView> createState() => _RecipeGridViewState();
}

class _RecipeGridViewState extends State<RecipeGridView> {
  List<Recipe> filteredRecipes = [];

  @override
  Widget build(BuildContext context) {
    final List<Recipe> allRecipes = context.watch<RecipeNotifier>().allRecipes;
    filteredRecipes = allRecipes.where((recipe) => recipe.category == widget.category).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category, style: Theme.of(context).textTheme.headlineLarge),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(recipeNotifier: context.read<RecipeNotifier>()),
              );
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 64, left: 8, right: 8),
          child: Center(
            child: filteredRecipes.isEmpty
                ? RichText(
                    text: TextSpan(
                      text: "There are no ",
                      style: Theme.of(context).textTheme.headlineMedium,
                      children: [
                        TextSpan(
                          text: widget.category,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                        ),
                        TextSpan(
                            text: "\nin your cookbook yet.\n\n", style: Theme.of(context).textTheme.headlineMedium),
                        TextSpan(
                          text: "Go ahead and add some!",
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        )
                      ],
                    ),
                    textAlign: TextAlign.center,
                  )
                : GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 0.6,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: [
                        ...filteredRecipes.map(
                          (recipe) => RecipeCard(recipeId: recipe.id),
                        )
                      ]),
          ),
        ),
      ),
      floatingActionButton: CustomFilledIconButton(
        text: "Add Recipe",
        iconData: Icons.add_box_outlined,
        newScreen: ChangeNotifierProvider(
          create: (_) {
            final RecipeFormNotifier recipeFormNotifier = RecipeFormNotifier();
            recipeFormNotifier.init();
            return recipeFormNotifier;
          },
          child: RecipeFormScreen(),
        ),
      ),
    );
  }
}
