import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:dishdrop_app_projekt/core/utils/check_amount_and_convert.dart';
import 'package:dishdrop_app_projekt/data/models/list_item.dart';
import 'package:dishdrop_app_projekt/data/models/shopping_list.dart';

import 'package:dishdrop_app_projekt/data/shopping_list_controller.dart';
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
  final TextEditingController _amountCtrl = TextEditingController();
  final TextEditingController _unitCtrl = TextEditingController();
  final TextEditingController _descriptionCtrl = TextEditingController();

  double? _ingredientAmount = 0;
  String? _ingredientUnit = "";
  String _ingredientDescription = "";

  @override
  Widget build(BuildContext context) {
    ShoppingList allPurposeShoppingList =
        widget.shoppingListController.getAllShoppingLists().first;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              allPurposeShoppingList.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.dishDropBlack),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  allPurposeShoppingList.imgUrl,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: List.generate(
                  allPurposeShoppingList.shoppingItems.length, (index) {
                return Container(
                  decoration: BoxDecoration(
                      color: index.isEven ? AppColors.lightGrey : Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      spacing: 10,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${checkAmountAndConvert(allPurposeShoppingList.shoppingItems[index].amount)} ${allPurposeShoppingList.shoppingItems[index].unit?.toString() ?? ''}",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        // Text(
                        //   "${allPurposeShoppingList.shoppingItems[index].amount?.toString() ?? ''} ${allPurposeShoppingList.shoppingItems[index].unit?.toString() ?? ''}",
                        //   style: Theme.of(context).textTheme.bodyLarge,
                        // ),
                        Expanded(
                          child: Text(
                            allPurposeShoppingList
                                .shoppingItems[index].description,
                            style: Theme.of(context).textTheme.bodyLarge,
                            textAlign: TextAlign.right,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10,
                    children: [
                      TextFormField(
                        controller: _descriptionCtrl,
                        onChanged: (value) => _ingredientDescription = value,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Ingredient description"),
                      ),
                      Row(
                        spacing: 10,
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _amountCtrl,
                              onChanged: (value) =>
                                  _ingredientAmount = double.tryParse(value),
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: AppColors.lightGrey,
                                border: OutlineInputBorder(),
                                hintText: "Amount",
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: _unitCtrl,
                              onChanged: (value) => value == ""
                                  ? _ingredientUnit = null
                                  : _ingredientUnit = value,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Unit"),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "You can enter fractional amounts like 1½ as 1.5",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(fontStyle: FontStyle.italic),
                      )
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        allPurposeShoppingList.addShoppingItem(
                          ListItem(
                            description: _ingredientDescription,
                            amount: _ingredientAmount,
                            unit: _ingredientUnit,
                          ),
                        );
                        _amountCtrl.clear();
                        _unitCtrl.clear();
                        _descriptionCtrl.clear();
                        _ingredientAmount = 0;
                        _ingredientUnit = "";
                        _ingredientDescription = "";
                      });
                    },
                    icon: Icon(
                      Icons.add_box_outlined,
                      size: 35,
                    ))
              ],
            ),
            SizedBox(height: 100)
          ],
        ),
      ),
    );
  }
}
