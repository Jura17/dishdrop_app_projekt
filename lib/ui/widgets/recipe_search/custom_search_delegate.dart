import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/provider/recipe_notifier.dart';
import 'package:dishdrop_app_projekt/ui/screens/recipe_details_screen.dart';
import 'package:dishdrop_app_projekt/ui/widgets/file_title_img.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_search/search_result_image.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_search/search_result_row.dart';
import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate {
  final RecipeNotifier recipeNotifier;
  bool showFavorites = false;

  CustomSearchDelegate({required this.recipeNotifier});

  List<Recipe> getFilteredRecipes(String query) {
    query = query.toLowerCase();

    if (query == '') return [];

    final List<Recipe> recipes = showFavorites
        ? recipeNotifier.allRecipes.where((recipe) => recipe.isFavorite).toList()
        : recipeNotifier.allRecipes;

    return recipes.where((recipe) {
      final titleMatch = recipe.title.toLowerCase().contains(query);
      final categoryMatch = recipe.category.toLowerCase().contains(query);
      final difficultyMatch = recipe.difficulty.toLowerCase().contains(query);
      final descriptionMatch = recipe.description.toLowerCase().contains(query);
      final notesMatch = recipe.notes.toLowerCase().contains(query);
      final tagsMatch = recipe.tags.any((tag) => tag.toLowerCase().contains(query));
      final prepTimeMatch = recipe.prepTime == int.tryParse(query);
      final cookingTimeMatch = recipe.cookingTime == int.tryParse(query);
      final ingredientsMatch =
          recipe.ingredients.any((ingredient) => ingredient.description.toLowerCase().contains(query));
      return titleMatch ||
          categoryMatch ||
          difficultyMatch ||
          descriptionMatch ||
          notesMatch ||
          tagsMatch ||
          prepTimeMatch ||
          cookingTimeMatch ||
          ingredientsMatch;
    }).toList();
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
      FavoriteFilterToggle(toggleFavoriteFunc: toggleFavorites)
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) => buildSuggestionAndResults(context);

  @override
  Widget buildSuggestions(BuildContext context) => buildSuggestionAndResults(context);

  Widget buildSuggestionAndResults(BuildContext context) {
    final List<Recipe> filteredRecipes = getFilteredRecipes(query);

    return ListView.builder(
      itemCount: filteredRecipes.length,
      itemBuilder: (context, index) {
        Recipe recipe = filteredRecipes[index];
        Widget imageWidget;

        if (recipe.images["titleImg"].contains("assets/images/")) {
          imageWidget = Image.asset(recipe.images["titleImg"], fit: BoxFit.cover);
        } else {
          imageWidget = FileTitleImg(imgPath: recipe.images["titleImg"]);
        }
        return GestureDetector(
          onTap: () => Navigator.of(context).push((MaterialPageRoute(
            builder: (context) => RecipeDetailsScreen(recipeId: recipe.id),
          ))),
          child: Container(
            color: index.isEven ? AppColors.lightGrey : Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 8.0, right: 8.0, bottom: 20.0),
              child: SearchResultRow(
                recipe: recipe,
                imageWidget: SearchResultImage(imageWidget: imageWidget),
              ),
            ),
          ),
        );
      },
    );
  }

  void toggleFavorites(bool showFavoritesInput) {
    showFavorites = showFavoritesInput;

    // hack to trigger UI rebuild inside delegate
    query = '$query ';
    query = query.trim();
  }
}

class FavoriteFilterToggle extends StatefulWidget {
  const FavoriteFilterToggle({
    super.key,
    required this.toggleFavoriteFunc,
  });

  final Function toggleFavoriteFunc;

  @override
  State<FavoriteFilterToggle> createState() => _FavoriteFilterToggleState();
}

class _FavoriteFilterToggleState extends State<FavoriteFilterToggle> {
  bool showFavorite = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          setState(() {
            showFavorite = !showFavorite;
            widget.toggleFavoriteFunc(showFavorite);
          });
        },
        icon: showFavorite
            ? Icon(
                Icons.favorite,
                color: AppColors.primary,
              )
            : Icon(Icons.favorite_outline));
  }
}
