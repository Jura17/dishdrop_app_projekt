import 'package:flutter/material.dart';

class ServingsPicker extends StatefulWidget {
  const ServingsPicker({super.key});

  @override
  State<ServingsPicker> createState() => _ServingsPickerState();
}

class _ServingsPickerState extends State<ServingsPicker> {
  int servings = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(Icons.person, size: 40),
        Row(
          children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    if (servings > 1) {
                      servings--;
                    }
                  });
                },
                icon: Icon(
                  Icons.remove_circle_outline,
                  size: 40,
                )),
            SizedBox(
              width: 40,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  servings.toString(),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    servings++;
                  });
                },
                icon: Icon(Icons.add_circle_outline_outlined, size: 40))
          ],
        )
      ],
    );
  }
}
