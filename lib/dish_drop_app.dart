import 'package:dishdrop_app_projekt/data/repositories/mock_database.dart';

import 'package:dishdrop_app_projekt/ui/screens/categories_screen.dart';
import 'package:dishdrop_app_projekt/ui/screens/recommendation_screen.dart';
import 'package:dishdrop_app_projekt/ui/screens/shopping_list_screen.dart';
import 'package:flutter/material.dart';

class DishDropApp extends StatefulWidget {
  const DishDropApp({super.key, required this.db});

  final MockDatabase db;

  @override
  State<DishDropApp> createState() => _DishDropAppState();
}

class _DishDropAppState extends State<DishDropApp> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        CategoriesScreen(db: widget.db),
        RecommendationScreen(db: widget.db),
        ShoppingListScreen(),
      ][activeIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: activeIndex,
        onTap: (index) => setState(() {
          activeIndex = index;
        }),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_rounded, size: 40),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb_outline, size: 40),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_grocery_store_outlined, size: 40),
            label: "",
          ),
        ],
      ),
    );
  }
}
