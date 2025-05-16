import 'package:flutter/material.dart';

class EntryPromptView extends StatelessWidget {
  const EntryPromptView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
            text: "Tap the ",
            style: Theme.of(context).textTheme.headlineLarge,
            children: [
              TextSpan(
                text: "button",
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
              ),
              TextSpan(text: " to find a recipe for today!")
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
