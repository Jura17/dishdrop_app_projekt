import 'package:dishdrop_app_projekt/ui/screens/categories_screen.dart';
import 'package:dishdrop_app_projekt/ui/screens/recommendation_screen.dart';
import 'package:dishdrop_app_projekt/ui/screens/shopping_list_screen.dart';
import 'package:flutter/material.dart';

// TODO: bug after adding recipe to shopping lists (probably a routing problem):
//       when tapping "Go to shopping list" on RecipeDetailScreen
//       shopping lists are up to date, but not when using bottom navbar tap "Shopping list"

// class DishDropApp extends StatefulWidget {
//   const DishDropApp({super.key});

//   @override
//   State<DishDropApp> createState() => _DishDropAppState();
// }

// class _DishDropAppState extends State<DishDropApp> {
//   int activeIndex = 0;

//   final List<GlobalKey<NavigatorState>> _navigatorKeys = [
//     GlobalKey<NavigatorState>(),
//     GlobalKey<NavigatorState>(),
//     GlobalKey<NavigatorState>(),
//   ];

//   void _onTap(int index) {
//     if (index == activeIndex) {
//       // If you tap again on the same tab, maybe pop to first route
//       _navigatorKeys[index].currentState?.popUntil((route) => route.isFirst);
//     } else {
//       setState(() {
//         activeIndex = index;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: IndexedStack(
//         index: activeIndex,
//         children: [
//           _buildTabNavigator(0, CategoriesScreen()),
//           _buildTabNavigator(1, RecommendationScreen()),
//           _buildTabNavigator(2, ShoppingListScreen()),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: activeIndex,
//         onTap: _onTap,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.menu_book_rounded, size: 40), label: ""),
//           BottomNavigationBarItem(icon: Icon(Icons.lightbulb_outline, size: 40), label: ""),
//           BottomNavigationBarItem(icon: Icon(Icons.local_grocery_store_outlined, size: 40), label: ""),
//         ],
//       ),
//     );
//   }

//   Widget _buildTabNavigator(int index, Widget child) {
//     return Navigator(
//       key: _navigatorKeys[index],
//       onGenerateRoute: (settings) {
//         return MaterialPageRoute(
//           builder: (_) => child,
//         );
//       },
//     );
//   }
// }

// TODO: Causes bottom nav bar to disappear when tapping "Go to shopping list" on RecipeDetailScreen
class DishDropApp extends StatefulWidget {
  const DishDropApp({
    super.key,
  });

  @override
  State<DishDropApp> createState() => _DishDropAppState();
}

class _DishDropAppState extends State<DishDropApp> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        CategoriesScreen(),
        RecommendationScreen(),
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
