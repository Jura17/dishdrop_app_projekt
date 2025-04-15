import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/recipe_controller.dart';
import 'package:dishdrop_app_projekt/data/shopping_list_controller.dart';
import 'package:dishdrop_app_projekt/ui/screens/recipe_form_screen.dart';

import 'package:dishdrop_app_projekt/ui/widgets/custom_filled_icon_button.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_card_widgets/recipe_card.dart';
import 'package:flutter/material.dart';

class RecipesGridView extends StatefulWidget {
  const RecipesGridView({
    super.key,
    required this.category,
  });
  final String category;

  @override
  State<RecipesGridView> createState() => _RecipesGridViewState();
}

class _RecipesGridViewState extends State<RecipesGridView> {
  List<Recipe> filteredRecipes = [];

  @override
  void initState() {
    // might not need initState -> use recipe consumer in build-method
    // filteredRecipes = widget.allRecipes.where((recipe) => recipe.category == widget.category).toList();
    super.initState();
  }

// vorher: /Users/julianrakow/Library/Developer/CoreSimulator/Devices/C31F3B0E-714B-48A8-AF90-9F6AAE590B16/data/Containers/Data/Application/491B8DBA-7F67-4300-9447-06A9E8101BB9/Documents/image_picker_F1A9D637-CF55-45BE-A81F-91AE8C2127D2-30108-00000AFB48519FA6.jpg
// nachher:/Users/julianrakow/Library/Developer/CoreSimulator/Devices/C31F3B0E-714B-48A8-AF90-9F6AAE590B16/data/Containers/Data/Application/560B5891-DFBF-43E7-A661-E93ED1FD8DAC/tmp/image_picker_B394936F-3AEA-4B3B-A94F-8D085FBCF27E-8870-00000AE18FB6073D.jpg
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category, style: Theme.of(context).textTheme.headlineLarge),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 64, left: 8, right: 8),
          child: Center(
            child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 0.6,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  ...filteredRecipes.map(
                    (recipe) => RecipeCard(recipe: recipe),
                  )
                ]),
          ),
        ),
      ),
      floatingActionButton: CustomFilledIconButton(
        text: "Add Recipe",
        iconData: Icons.add_box_outlined,
        newScreen: RecipeFormScreen(),
      ),
    );
  }
}
