import 'package:flutter/material.dart';

class NewRecipeScreen extends StatefulWidget {
  const NewRecipeScreen({super.key});

  @override
  State<NewRecipeScreen> createState() => _NewRecipeScreenState();
}

class _NewRecipeScreenState extends State<NewRecipeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new recipe",
            style: Theme.of(context).textTheme.headlineLarge),
      ),
      body: Center(
        child: Text("new recipe form"),
      ),
    );
  }
}
