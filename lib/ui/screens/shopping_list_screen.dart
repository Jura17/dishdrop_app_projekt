import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:dishdrop_app_projekt/data/provider/recipe_notifier.dart';
import 'package:dishdrop_app_projekt/data/provider/shopping_list_notifier.dart';

import 'package:dishdrop_app_projekt/ui/widgets/all_purpose_shopping_list_view_widgets/all_purpose_shopping_list_view.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_search/custom_search_delegate.dart';

import 'package:dishdrop_app_projekt/ui/widgets/recipe_shopping_list_widgets/recipe_shopping_lists_outer_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingListScreen extends StatefulWidget {
  const ShoppingListScreen({
    super.key,
  });

  @override
  State<ShoppingListScreen> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  int activeIndex = 0;

  @override
  void initState() {
    context.read<ShoppingListNotifier>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shopping Lists",
          style: Theme.of(context).textTheme.headlineLarge,
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
      body: [
        RecipeShoppingListsOuterContainer(),
        AllPurposeShoppingListView(),
      ][activeIndex],
      floatingActionButton: ShoppingListSegmentButton(onSelectionChangedFunc: onSelectionChanged),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void onSelectionChanged(newSelectionIndex) {
    setState(() {
      activeIndex = newSelectionIndex;
    });
  }
}

class ShoppingListSegmentButton extends StatefulWidget {
  const ShoppingListSegmentButton({
    super.key,
    required this.onSelectionChangedFunc,
  });

  final Function onSelectionChangedFunc;

  @override
  State<ShoppingListSegmentButton> createState() => _ShoppingListSegmentButtonState();
}

class _ShoppingListSegmentButtonState extends State<ShoppingListSegmentButton> {
  Set<int> _selected = {0};

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<int>(
      style: SegmentedButton.styleFrom(
        foregroundColor: AppColors.primary,
        backgroundColor: AppColors.lightGreen,
        selectedBackgroundColor: AppColors.primary,
        selectedForegroundColor: Colors.white,
      ),
      emptySelectionAllowed: false,
      showSelectedIcon: false,
      multiSelectionEnabled: false,
      segments: <ButtonSegment<int>>[
        ButtonSegment(value: 0, label: Text("By Recipe")),
        ButtonSegment(value: 1, label: Text("All-Purpose List")),
      ],
      selected: _selected,
      onSelectionChanged: updateSelected,
    );
  }

  void updateSelected(Set<int> newSelection) {
    setState(() {
      _selected = newSelection;
      widget.onSelectionChangedFunc(_selected.first);
    });
  }
}
