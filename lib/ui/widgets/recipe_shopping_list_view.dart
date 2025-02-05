import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:dishdrop_app_projekt/data/models/shopping_list.dart';
import 'package:dishdrop_app_projekt/data/repositories/mock_database.dart';
import 'package:flutter/material.dart';

class RecipeShoppingListView extends StatefulWidget {
  const RecipeShoppingListView({super.key, required this.db});

  final MockDatabase db;

  @override
  State<RecipeShoppingListView> createState() => _RecipeShoppingListViewState();
}

class _RecipeShoppingListViewState extends State<RecipeShoppingListView> {
  @override
  Widget build(BuildContext context) {
    // List allRecipeShoppingLists = widget.db.getAllShoppingLists();

    return Center(child: Text("Recipe Shopping lists"));

    // return ListView.builder(
    //   itemCount: allRecipeShoppingLists.length,
    //   itemBuilder: (BuildContext context, int index) {
    //     return Container(
    //       color: AppColors.lightGrey,
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Text(allRecipeShoppingLists[index].title),
    //           // ...allRecipeShoppingLists[index].shoppingItems.map(
    //           //       (item) => Column(
    //           //         children: [ListTile(title: item)],
    //           //       ),
    //           //     )
    //         ],
    //       ),
    //     );
    //   },
    // );
  }
}
