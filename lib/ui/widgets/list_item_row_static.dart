import 'package:dishdrop_app_projekt/core/utils/check_and_convert_amount.dart';
import 'package:flutter/material.dart';

class ListItemRowStatic extends StatelessWidget {
  const ListItemRowStatic({
    super.key,
    required this.amount,
    required this.unit,
    required this.description,
  });

  final double? amount;
  final String? unit;
  final String description;

  @override
  Widget build(BuildContext context) {
    List<String> convertedAmount = checkAndconvertAmount(amount);

    return Row(
      spacing: 10,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: convertedAmount[0],
            style: Theme.of(context).textTheme.bodyLarge,
            children: [
              TextSpan(
                text: convertedAmount[1],
                style: TextStyle(
                  fontFeatures: [FontFeature.fractions()],
                ),
              ),
              TextSpan(
                text: " ${unit ?? ''}",
                style: Theme.of(context).textTheme.bodyLarge,
              )
            ],
          ),
        ),
        Expanded(
          child: Text(
            description,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
