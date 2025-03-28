import 'package:dishdrop_app_projekt/core/utils/show_custom_alert_banner.dart';
import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/models/shopping_list.dart';

import 'package:dishdrop_app_projekt/data/recipe_controller.dart';
import 'package:dishdrop_app_projekt/data/shopping_list_controller.dart';
import 'package:dishdrop_app_projekt/ui/screens/recipe_form_screen.dart';

import 'package:dishdrop_app_projekt/ui/widgets/recipe_details_screen_widgets/description_section.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_details_screen_widgets/directions_section.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_details_screen_widgets/footer_button_section.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_details_screen_widgets/recipe_details_ingredients_section.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_details_screen_widgets/quick_info_section.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_details_screen_widgets/recipe_details_title_image.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_details_screen_widgets/tags_section.dart';

import 'package:dishdrop_app_projekt/ui/widgets/custom_filled_icon_button.dart';

import 'package:flutter/material.dart';

class RecipeDetailsScreen extends StatefulWidget {
  const RecipeDetailsScreen({
    super.key,
    required this.recipe,
    required this.recipeController,
    required this.shoppingListController,
  });
  final Recipe recipe;
  final RecipeController recipeController;
  final ShoppingListController shoppingListController;

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

  @override
  void initState() {
    _directionsEmpty = widget.recipe.directions.isEmpty;
    _ingredientsEmpty = widget.recipe.ingredients.isEmpty;

    getAllShoppingLists();
    super.initState();
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

  double defaultSpacing = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          child: Text(widget.recipe.title, style: Theme.of(context).textTheme.headlineLarge),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 80, left: 16, right: 16),
        child: ListView(
          controller: _scrollController,
          children: [
            RecipeDetailsTitleImage(widget: widget),
            SizedBox(height: defaultSpacing),
            QuickInfoSection(widget: widget),
            SizedBox(height: defaultSpacing),
            if (widget.recipe.tags.isNotEmpty) TagsSection(recipe: widget.recipe),
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
            if (widget.recipe.description != "") DescriptionSection(recipe: widget.recipe),
            SizedBox(height: defaultSpacing),
            if (!_directionsEmpty)
              DirectionsSection(
                key: _directionsKey,
                recipe: widget.recipe,
              ),
            SizedBox(height: defaultSpacing),
            if (!_ingredientsEmpty)
              RecipeDetailsIngredientsSection(
                key: _ingredientsKey,
                recipe: widget.recipe,
                shoppingListController: widget.shoppingListController,
                addShoppingListFunc: addShoppingList,
                allShoppingLists: allShoppingLists,
              ),
            SizedBox(height: 40),
            RichText(
              text: TextSpan(
                text: "You have cooked this dish ",
                style: Theme.of(context).textTheme.bodyLarge,
                children: [
                  TextSpan(
                    text: "${widget.recipe.timesCooked}",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: " times so far.\nTap the button below when you're done!")
                ],
              ),
            ),
            SizedBox(height: 20),
            FooterButtonSection(
                recipeController: widget.recipeController,
                recipe: widget.recipe,
                updateCounterTimesCooked: updateCounterTimesCooked,
                showBanner: showBanner),
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
            recipeController: widget.recipeController,
            shoppingListController: widget.shoppingListController,
            newScreen: RecipeFormScreen(
                recipeController: widget.recipeController,
                shoppingListController: widget.shoppingListController,
                recipe: widget.recipe),
          ),
          CustomFilledIconButton(
            text: "Add Recipe",
            iconData: Icons.add_box_outlined,
            recipeController: widget.recipeController,
            shoppingListController: widget.shoppingListController,
            newScreen: RecipeFormScreen(
              recipeController: widget.recipeController,
              shoppingListController: widget.shoppingListController,
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void updateCounterTimesCooked() {
    setState(() {
      widget.recipe.timesCooked++;
    });
  }

  Future<void> getAllShoppingLists() async {
    allShoppingLists = await widget.shoppingListController.getAllShoppingListsFuture();
  }

  Future<void> addShoppingList(ShoppingList shoppingList) async {
    await widget.shoppingListController.addShoppingListFuture(shoppingList);
    setState(() {});
  }

  void showBanner() {
    setState(() {
      widget.recipeController.removeRecipe(widget.recipe);
      showCustomAlertBanner(context, Colors.red, "Recipe removed from cookbook.");
    });
    Navigator.of(context).pop();
  }
}
