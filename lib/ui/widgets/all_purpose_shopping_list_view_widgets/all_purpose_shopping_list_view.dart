import 'package:dishdrop_app_projekt/data/models/list_item.dart';
import 'package:dishdrop_app_projekt/data/models/shopping_list.dart';
import 'package:dishdrop_app_projekt/data/provider/shopping_list_notifier.dart';

import 'package:dishdrop_app_projekt/ui/widgets/all_purpose_shopping_list_view_widgets/all_purpose_list_input_section.dart';
import 'package:dishdrop_app_projekt/ui/widgets/all_purpose_shopping_list_view_widgets/all_purpose_list_items.dart';
import 'package:dishdrop_app_projekt/ui/widgets/all_purpose_shopping_list_view_widgets/all_purpose_list_title_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllPurposeShoppingListView extends StatefulWidget {
  const AllPurposeShoppingListView({super.key});

  @override
  State<AllPurposeShoppingListView> createState() => _AllPurposeShoppingListViewState();
}

class _AllPurposeShoppingListViewState extends State<AllPurposeShoppingListView> {
  ShoppingList? allPurposeShoppingList;
  final _formKey = GlobalKey<FormState>();

  final Map<String, TextEditingController> allTextControllers = {
    "itemAmountCtrl": TextEditingController(),
    "itemUnitCtrl": TextEditingController(),
    "itemDescCtrl": TextEditingController(),
  };

  @override
  Widget build(BuildContext context) {
    allPurposeShoppingList = context.watch<ShoppingListNotifier>().getAllPurposeShoppingList();

    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  allPurposeShoppingList!.title,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(height: 10),
                AllPurposeListTitleImage(allPurposeShoppingList: allPurposeShoppingList!),
                const SizedBox(height: 20),
                allPurposeShoppingList!.shoppingItems.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: Text(
                            "No shopping items added yet",
                          ),
                        ),
                      )
                    : AllPurposeListItems(allPurposeShoppingList: allPurposeShoppingList!),
                SizedBox(height: 20),
                AllPurposeListInputSection(
                  allTextControllers: allTextControllers,
                  updateListFunction: updateAllPurposeShoppingList,
                  formKey: _formKey,
                ),
                SizedBox(height: 100)
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updateAllPurposeShoppingList() {
    setState(() {
      if (allPurposeShoppingList != null) {
        context.read<ShoppingListNotifier>().addToAllPurposeShoppingList(
              ListItem(
                description: allTextControllers["itemDescCtrl"]!.text,
                amount: double.tryParse(allTextControllers["itemAmountCtrl"]!.text),
                unit: allTextControllers["itemUnitCtrl"]!.text,
              ),
            );
        allTextControllers["itemAmountCtrl"]!.clear();
        allTextControllers["itemUnitCtrl"]!.clear();
        allTextControllers["itemDescCtrl"]!.clear();
      }
    });
  }
}
