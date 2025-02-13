import 'package:flutter/material.dart';

class CookingDirectionsListView extends StatelessWidget {
  const CookingDirectionsListView({
    super.key,
    required this.complexInputValues,
  });

  final Map<String, dynamic> complexInputValues;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        complexInputValues["directions"].length,
        (index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${index + 1}. ",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Expanded(
                  child: Text(
                    complexInputValues["directions"][index],
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
