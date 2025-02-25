import 'package:dishdrop_app_projekt/core/utils/check_amount_and_convert.dart';
import 'package:flutter/material.dart';

class ListItemRow extends StatelessWidget {
  const ListItemRow({
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
    return Row(
      spacing: 10,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: getWholeNumberOfAmount(amount),
            style: Theme.of(context).textTheme.bodyLarge,
            children: [
              TextSpan(
                text: getFractionalPartOfAmount(amount),
                style: TextStyle(
                  fontFeatures: [FontFeature.fractions()],
                ),
              ),
              TextSpan(text: " ${unit ?? ''}")
            ],
          ),
        ),
        Expanded(
          child: Text(
            description,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.right,
          ),
        )
      ],
    );
  }
}
