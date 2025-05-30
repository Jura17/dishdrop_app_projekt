import 'package:flutter/material.dart';

class ServingsPicker extends StatefulWidget {
  const ServingsPicker({
    super.key,
    required this.updateServingsFunc,
    required this.servings,
  });

  final void Function(int newAmount) updateServingsFunc;
  final int servings;

  @override
  State<ServingsPicker> createState() => _ServingsPickerState();
}

class _ServingsPickerState extends State<ServingsPicker> {
  late int servings;
  @override
  void initState() {
    servings = widget.servings;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(Icons.person, size: 40),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  if (servings > 1) {
                    servings--;
                    widget.updateServingsFunc(servings);
                  }
                });
              },
              icon: Icon(
                Icons.remove_circle_outline,
                size: 40,
              ),
            ),
            SizedBox(
              width: 25,
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
                  widget.updateServingsFunc(servings);
                });
              },
              icon: Icon(Icons.add_circle_outline_outlined, size: 40),
            )
          ],
        )
      ],
    );
  }
}
