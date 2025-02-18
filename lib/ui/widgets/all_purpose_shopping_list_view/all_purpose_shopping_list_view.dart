import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';

import 'package:dishdrop_app_projekt/data/models/list_item.dart';
import 'package:dishdrop_app_projekt/data/models/shopping_list.dart';

import 'package:dishdrop_app_projekt/data/shopping_list_controller.dart';
import 'package:dishdrop_app_projekt/ui/widgets/all_purpose_shopping_list_view/all_purpose_list_items.dart';
import 'package:dishdrop_app_projekt/ui/widgets/all_purpose_shopping_list_view/all_purpose_list_title_image.dart';
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
    ShoppingList allPurposeShoppingList;

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
                    allPurposeShoppingList.title,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  AllPurposeListTitleImage(
                      allPurposeShoppingList: allPurposeShoppingList),
                  const SizedBox(height: 20),
                  AllPurposeListItems(
                      allPurposeShoppingList: allPurposeShoppingList),
                  SizedBox(height: 20),
                  buildAllPurposeListInputSection(
                      context, allPurposeShoppingList),
                  SizedBox(height: 100)
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // TODO: make this a stateful widget instead of a function
  Row buildAllPurposeListInputSection(
      BuildContext context, ShoppingList allPurposeShoppingList) {
    return Row(
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
                          border: OutlineInputBorder(), hintText: "Unit"),
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
            setState(
              () {
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
              },
            );
          },
          icon: Icon(
            Icons.add_box_outlined,
            size: 35,
          ),
        )
      ],
    );
  }
}

// class AllPurposeListInputSection extends StatefulWidget {
//   const AllPurposeListInputSection({
//     super.key,
//     required this.allTextFormCtrl,
//     required this.inputValues,
//     required this.updateList,
//   });

//   final Map<String, TextEditingController> allTextFormCtrl;
//   final Map<String, dynamic> inputValues;
//   final Function updateList;

//   @override
//   State<AllPurposeListInputSection> createState() =>
//       _AllPurposeListInputSectionState();
// }

// class _AllPurposeListInputSectionState
//     extends State<AllPurposeListInputSection> {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             spacing: 10,
//             children: [
//               TextFormField(
//                 controller: widget.descriptionCtrl,
//                 onChanged: (value) => _ingredientDescription = value,
//                 decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     hintText: "Ingredient description"),
//               ),
//               Row(
//                 spacing: 10,
//                 children: [
//                   Expanded(
//                     child: TextFormField(
//                       controller: _amountCtrl,
//                       onChanged: (value) =>
//                           _ingredientAmount = double.tryParse(value),
//                       decoration: const InputDecoration(
//                         filled: true,
//                         fillColor: AppColors.lightGrey,
//                         border: OutlineInputBorder(),
//                         hintText: "Amount",
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: TextFormField(
//                       controller: _unitCtrl,
//                       onChanged: (value) => value == ""
//                           ? _ingredientUnit = null
//                           : _ingredientUnit = value,
//                       decoration: const InputDecoration(
//                           border: OutlineInputBorder(), hintText: "Unit"),
//                     ),
//                   ),
//                 ],
//               ),
//               Text(
//                 "You can enter fractional amounts like 1½ as 1.5",
//                 style: Theme.of(context)
//                     .textTheme
//                     .labelMedium
//                     ?.copyWith(fontStyle: FontStyle.italic),
//               )
//             ],
//           ),
//         ),
//         IconButton(
//           onPressed: () {
//             setState(
//               () {
//                 allPurposeShoppingList.addShoppingItem(
//                   ListItem(
//                     description: _ingredientDescription,
//                     amount: _ingredientAmount,
//                     unit: _ingredientUnit,
//                   ),
//                 );
//                 _amountCtrl.clear();
//                 _unitCtrl.clear();
//                 _descriptionCtrl.clear();
//                 _ingredientAmount = 0;
//                 _ingredientUnit = "";
//                 _ingredientDescription = "";
//               },
//             );
//           },
//           icon: Icon(
//             Icons.add_box_outlined,
//             size: 35,
//           ),
//         )
//       ],
//     );
//   }
// }
