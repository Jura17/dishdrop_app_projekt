import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/models/shopping_list.dart';

import 'package:dishdrop_app_projekt/data/provider/recipe_notifier.dart';

import 'package:dishdrop_app_projekt/ui/widgets/recipe_details_screen_widgets/description_section.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_details_screen_widgets/directions_section.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_details_screen_widgets/notes_section.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_details_screen_widgets/recipe_details_footer_button_section.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_details_screen_widgets/recipe_details_ingredients_section.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_details_screen_widgets/quick_info_section.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_details_screen_widgets/recipe_details_title_image.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_details_screen_widgets/tags_section.dart';

import 'package:dishdrop_app_projekt/ui/widgets/custom_filled_icon_button.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_search/custom_search_delegate.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RecipeDetailsScreen extends StatefulWidget {
  const RecipeDetailsScreen({
    super.key,
    required this.recipeId,
  });
  final int recipeId;

  @override
  State<RecipeDetailsScreen> createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _directionsKey = GlobalKey();
  final GlobalKey _ingredientsKey = GlobalKey();
  bool _directionsEmpty = false;
  bool _ingredientsEmpty = false;
  List<ShoppingList> allShoppingLists = [];
  Recipe? recipe;
  double defaultSpacing = 20;
  int servings = 1;

  @override
  Widget build(BuildContext context) {
    recipe = context.watch<RecipeNotifier>().getRecipeById(widget.recipeId);

    // null check to prevent app from crashing when deleting the recipe
    if (recipe == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Recipe not found")),
        body: Center(child: Text("This recipe has been deleted.")),
      );
    }
    _directionsEmpty = recipe!.directions.isEmpty;
    _ingredientsEmpty = recipe!.ingredients.isEmpty;
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          child: Text(recipe!.title, style: Theme.of(context).textTheme.headlineLarge),
        ),
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
      body: Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 80, left: 16, right: 16),
        child: ListView(
          controller: _scrollController,
          children: [
            RecipeDetailsTitleImage(recipe: recipe!),
            SizedBox(height: defaultSpacing),
            QuickInfoSection(recipe: recipe!),
            SizedBox(height: defaultSpacing),
            if (recipe!.tags.isNotEmpty) TagsSection(recipe: recipe!),
            SizedBox(height: defaultSpacing),
            if (!_directionsEmpty || !_ingredientsEmpty)
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton(
                  onPressed: () => _jumpToCookingDirections(),
                  child: Text("Jump to recipe"),
                ),
              ),
            SizedBox(height: defaultSpacing),
            if (recipe!.description != "") DescriptionSection(recipe: recipe!),
            SizedBox(height: defaultSpacing),
            if (!_directionsEmpty)
              DirectionsSection(
                key: _directionsKey,
                recipe: recipe!,
              ),
            SizedBox(height: defaultSpacing),
            if (recipe!.notes != "") NotesSection(recipe: recipe!),
            SizedBox(height: defaultSpacing),
            if (!_ingredientsEmpty)
              RecipeDetailsIngredientsSection(
                key: _ingredientsKey,
                recipeId: widget.recipeId,
                servingsInput: servings,
                updateServingsFunc: updateServings,
              ),
            SizedBox(height: 40),
            RichText(
              text: TextSpan(
                text: "You have cooked this dish ",
                style: Theme.of(context).textTheme.bodyLarge,
                children: [
                  TextSpan(
                    text: "${recipe!.timesCooked}",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                      text:
                          " ${recipe!.timesCooked == 1 ? "time" : "times"} so far.\nTap the button below when you're done!")
                ],
              ),
            ),
            SizedBox(height: 20),
            RecipeDetailsFooterButtonSection(
              recipe: recipe!,
            ),
            SizedBox(height: 130),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 10,
        children: [
          CustomFilledIconButton(
            text: "Edit Recipe",
            iconData: Icons.edit,
            onPressed: () => context.push(
              '/categories/edit-recipe/${recipe!.id.toString()}',
            ),
          ),
          CustomFilledIconButton(
            text: "Add Recipe",
            iconData: Icons.add_box_outlined,
            onPressed: () => context.push('/categories/add-recipe'),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _jumpToCookingDirections() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // if there are no cooking directions for that recipe try to scroll to the ingredient's section instead if there are any
      BuildContext? targetContext = _directionsEmpty ? _ingredientsKey.currentContext : _directionsKey.currentContext;

      if (targetContext != null) {
        final RenderBox renderbox = targetContext.findRenderObject() as RenderBox;
        final Offset position = renderbox.localToGlobal(
          Offset.zero,
          ancestor: context.findRenderObject(),
        );
        _scrollController.animateTo(position.dy + _scrollController.offset - 150,
            duration: Duration(seconds: 1), curve: Curves.easeInOut);
      }
    });
  }

  void updateServings(newAmount) {
    setState(() {
      servings = newAmount;
    });
  }
}
