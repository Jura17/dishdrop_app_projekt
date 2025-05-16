import 'package:dishdrop_app_projekt/ui/widgets/recommendation_button.dart';
import 'package:flutter/material.dart';

class RecommendationScreen extends StatefulWidget {
  const RecommendationScreen({
    super.key,
  });

  @override
  State<RecommendationScreen> createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  final List<RecipeQuestions> recipeQuestions = [
    RecipeQuestions(
      question: "What category are you looking for?",
      options: ["Appetizers", "Main Courses", "Side Dishes", "Salads", "Sweet Stuff", "Drinks"],
    ),
    RecipeQuestions(
      question: "What difficulty shall it be?",
      options: ["Something simple please", "Not too tricky", "Let's go big", "Anything works"],
    ),
    RecipeQuestions(
      question: "How much time do you have?",
      options: ["30 minutes max", "Not more than one hour", "Time doesn't matter"],
    ),
    RecipeQuestions(
      question: "Something you have tried before? A new recipe maybe?",
      options: ["Give me something fresh", "Something I've cooked before", "I don't care"],
    ),
    RecipeQuestions(
      question: "Do you want one of your favorites?",
      options: ["Yeah, favorites only", "None-favorites, please", "Doesn't matter"],
    )
  ];

  int _currentQuestionIndex = -1;
  Map<int, String> answers = {};

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

class RecipeQuestions {
  final String question;
  final List<String> options;

  RecipeQuestions({
    required this.question,
    required this.options,
  });
}
