import 'package:flutter/material.dart';

class DirectionsListView extends StatelessWidget {
  const DirectionsListView({
    super.key,
    required Map<String, dynamic> userInputValues,
  }) : _userInputValues = userInputValues;

  final Map<String, dynamic> _userInputValues;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        _userInputValues["directions"].length,
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
                    _userInputValues["directions"][index],
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
