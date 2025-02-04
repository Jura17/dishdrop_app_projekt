import 'package:dishdrop_app_projekt/ui/widgets/shopping_list_segment_button.dart';
import 'package:flutter/material.dart';

class ShoppingListScreen extends StatelessWidget {
  const ShoppingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping List",
            style: Theme.of(context).textTheme.headlineLarge),
      ),
      body: Scaffold(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ShoppingListSegmentButton(),
        ],
      ),
    );
  }
}
