import 'package:dishdrop_app_projekt/data/models/recommendation_question.dart';
import 'package:flutter/material.dart';

class PromptView extends StatelessWidget {
  const PromptView({
    required this.currentQuestionIndex,
    required this.incrementQuestionIndexFunc,
    required this.updateAnswersFunc,
    required this.recommendationPrompt,
    super.key,
  });

  final int currentQuestionIndex;
  final Function incrementQuestionIndexFunc;
  final Function updateAnswersFunc;
  final RecommendationPrompt recommendationPrompt;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          recommendationPrompt.question,
          style: Theme.of(context).textTheme.headlineLarge,
          textAlign: TextAlign.center,
        ),
        Column(
          children: recommendationPrompt.options.keys
              .map(
                (optionKey) => ElevatedButton(
                  onPressed: () {
                    updateAnswersFunc(currentQuestionIndex, recommendationPrompt.options[optionKey]);
                    incrementQuestionIndexFunc();
                  },
                  child: Text(optionKey),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
