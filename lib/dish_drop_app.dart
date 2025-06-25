import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DishDropApp extends StatefulWidget {
  final StatefulNavigationShell shell;

  const DishDropApp({
    super.key,
    required this.shell,
  });

  @override
  State<DishDropApp> createState() => _DishDropAppState();
}

class _DishDropAppState extends State<DishDropApp> {
  void _onTap(int index) {
    // go back to root of tab when tapping more than once
    widget.shell.goBranch(index, initialLocation: index == widget.shell.currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.shell,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: widget.shell.currentIndex,
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
