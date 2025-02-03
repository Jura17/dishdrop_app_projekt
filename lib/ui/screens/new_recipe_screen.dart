import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
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
        title: Text("New recipe",
            style: Theme.of(context).textTheme.headlineLarge),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              spacing: 10,
              children: [
                TextFormField(
                  decoration: const InputDecoration(hintText: "Title"),
                ),
                SizedBox(height: 10),
                DropdownMenu(
                  width: double.infinity,
                  dropdownMenuEntries: [
                    DropdownMenuEntry(value: "Appetizers", label: "Appetizers"),
                    DropdownMenuEntry(
                        value: "Main Courses", label: "Main Courses"),
                    DropdownMenuEntry(
                        value: "Side Dishes", label: "Side Dishes"),
                    DropdownMenuEntry(value: "Salads", label: "Salads"),
                    DropdownMenuEntry(
                        value: "Sweet Stuff", label: "Sweet Stuff"),
                    DropdownMenuEntry(value: "Drinks", label: "Drinks")
                  ],
                  hintText: "Select category",
                ),
                GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(height: 30),
                        Container(
                          width: 250,
                          height: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.dishDropBlack),
                          ),
                          child: Icon(
                            Icons.camera_alt_outlined,
                            size: 50,
                            color: AppColors.dishDropBlack,
                          ),
                        ),
                        TextFormField(
                          decoration:
                              const InputDecoration(hintText: "Image-URL"),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                DropdownMenu(
                  width: double.infinity,
                  dropdownMenuEntries: [
                    DropdownMenuEntry(value: "Simple", label: "Simple"),
                    DropdownMenuEntry(
                        value: "Not Too Tricky", label: "Not Too Tricky"),
                    DropdownMenuEntry(value: "Impressive", label: "Impressive"),
                  ],
                  hintText: "Select difficulty",
                ),
                TextFormField(
                  decoration: const InputDecoration.collapsed(
                    hintText: "Tags",
                    filled: true,
                    fillColor: AppColors.lightGrey,
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Description",
                    filled: true,
                    fillColor: AppColors.lightGrey,
                    contentPadding: EdgeInsets.symmetric(vertical: 50),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration:
                            const InputDecoration(hintText: "Prep Time"),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration:
                            const InputDecoration(hintText: "Cook Time"),
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Notes",
                    contentPadding: EdgeInsets.symmetric(vertical: 50),
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Text("Directions",
                        style: Theme.of(context).textTheme.headlineMedium),
                    Spacer(),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                          decoration: const InputDecoration(
                              hintText: "Add instruction")),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.add_box_outlined,
                          size: 35,
                        ))
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Text("Ingredients",
                        style: Theme.of(context).textTheme.headlineMedium),
                    Spacer(),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                          decoration: const InputDecoration(
                              hintText: "Add ingredient")),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.add_box_outlined,
                          size: 35,
                        ))
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  spacing: 10,
                  children: [
                    FilledButton(
                      onPressed: () {},
                      child: Text("Save recipe"),
                    ),
                    FilledButton(
                      onPressed: () {},
                      child: Text("Save and open recipe"),
                    )
                  ],
                ),
                SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
