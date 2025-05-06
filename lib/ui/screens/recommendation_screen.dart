import 'package:dishdrop_app_projekt/ui/widgets/recommendation_button.dart';
import 'package:flutter/material.dart';

class RecommendationScreen extends StatelessWidget {
  const RecommendationScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Column(
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
          Spacer(),
          RecommendationButton(),
          Spacer(),
        ],
      )),
    );
  }
}
