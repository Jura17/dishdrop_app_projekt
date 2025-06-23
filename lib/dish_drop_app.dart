import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DishDropApp extends StatefulWidget {
  final StatefulNavigationShell shell;
  final List<GlobalKey<NavigatorState>> navigatorKeys;

  const DishDropApp({
    super.key,
    required this.shell,
    required this.navigatorKeys,
  });

  @override
  State<DishDropApp> createState() => _DishDropAppState();
}

class _DishDropAppState extends State<DishDropApp> {
  int _currentIndex = 0;

  // go back to root of tab when tapping more than once
  void _onTap(int index) {
    if (index == _currentIndex) {
      final key = widget.navigatorKeys[index];
      key.currentState?.popUntil((route) => route.isFirst);
    } else {
      widget.shell.goBranch(index);
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.shell,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _onTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.menu_book_rounded, size: 32), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.lightbulb_outline, size: 32), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.local_grocery_store_outlined, size: 32), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.settings_outlined, size: 32), label: ""),
        ],
      ),
    );
  }
}
