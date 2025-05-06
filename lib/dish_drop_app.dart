import 'package:dishdrop_app_projekt/ui/screens/categories_screen.dart';
import 'package:dishdrop_app_projekt/ui/screens/recommendation_screen.dart';
import 'package:dishdrop_app_projekt/ui/screens/shopping_list_screen.dart';
import 'package:flutter/material.dart';

class DishDropApp extends StatefulWidget {
  const DishDropApp({super.key});

  @override
  State<DishDropApp> createState() => _DishDropAppState();
}

class _DishDropAppState extends State<DishDropApp> {
  int activeIndex = 0;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  void _onTap(int index) {
    if (index == activeIndex) {
      _navigatorKeys[index].currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        activeIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: activeIndex,
        children: [
          _buildTabNavigator(0, CategoriesScreen()),
          _buildTabNavigator(1, RecommendationScreen()),
          _buildTabNavigator(2, ShoppingListScreen()),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: activeIndex,
        onTap: _onTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.menu_book_rounded, size: 40), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.lightbulb_outline, size: 40), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.local_grocery_store_outlined, size: 40), label: ""),
        ],
      ),
    );
  }

  Widget _buildTabNavigator(int index, Widget child) {
    return Navigator(
      key: _navigatorKeys[index],
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (_) => child,
        );
      },
    );
  }
}
