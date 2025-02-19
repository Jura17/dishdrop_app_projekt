import 'package:dishdrop_app_projekt/data/models/list_item.dart';
import 'package:dishdrop_app_projekt/data/models/shopping_list.dart';

import 'package:dishdrop_app_projekt/data/shopping_list_controller.dart';
import 'package:dishdrop_app_projekt/ui/widgets/all_purpose_shopping_list_view_widgets/all_purpose_list_input_section.dart';
import 'package:dishdrop_app_projekt/ui/widgets/all_purpose_shopping_list_view_widgets/all_purpose_list_items.dart';
import 'package:dishdrop_app_projekt/ui/widgets/all_purpose_shopping_list_view_widgets/all_purpose_list_title_image.dart';
import 'package:flutter/material.dart';

class AllPurposeShoppingListView extends StatefulWidget {
  const AllPurposeShoppingListView(
      {super.key, required this.shoppingListController});

  final ShoppingListController shoppingListController;

  @override
  State<AllPurposeShoppingListView> createState() =>
      _AllPurposeShoppingListViewState();
}

class _AllPurposeShoppingListViewState
    extends State<AllPurposeShoppingListView> {
  ShoppingList? allPurposeShoppingList;

  final Map<String, TextEditingController> allTextControllers = {
    "itemAmountCtrl": TextEditingController(),
    "itemUnitCtrl": TextEditingController(),
    "itemDescCtrl": TextEditingController(),
  };

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: widget.shoppingListController.getAllShoppingListsFuture(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text("Error while fetching data: ${snapshot.error}");
          }
          allPurposeShoppingList = snapshot.data!.first;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    allPurposeShoppingList!.title,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  AllPurposeListTitleImage(
                      allPurposeShoppingList: allPurposeShoppingList!),
                  const SizedBox(height: 20),
                  AllPurposeListItems(
                      allPurposeShoppingList: allPurposeShoppingList!),
                  SizedBox(height: 20),
                  AllPurposeListInputSection(
                      allTextControllers: allTextControllers,
                      updateListFunction: updateAllPurposeShoppingList),
                  SizedBox(height: 100)
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // TODO: all-purpose shopping list also needs to be updated in the database
  void updateAllPurposeShoppingList() {
    setState(
      () {
        allPurposeShoppingList!.addShoppingItem(
          ListItem(
            description: allTextControllers["itemDescCtrl"]!.text,
            amount: double.tryParse(allTextControllers["itemAmountCtrl"]!.text),
            unit: allTextControllers["itemUnitCtrl"]!.text,
          ),
        );
        allTextControllers["itemAmountCtrl"]!.clear();
        allTextControllers["itemUnitCtrl"]!.clear();
        allTextControllers["itemDescCtrl"]!.clear();
      },
    );
  }
}
