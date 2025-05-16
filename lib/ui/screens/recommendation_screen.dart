import 'package:dishdrop_app_projekt/data/repositories/recommendation_data.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recommendation_button.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recommendation_card_view_widgets/entry_prompt_view.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recommendation_card_view_widgets/prompt_view.dart';
import 'package:flutter/material.dart';

class RecommendationScreen extends StatefulWidget {
  const RecommendationScreen({
    super.key,
  });

  @override
  State<RecommendationScreen> createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  int _currentQuestionIndex = -1;
  Map<int, Enum> answers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _currentQuestionIndex < 0
                ? EntryPromptView()
                : PromptView(
                    currentQuestionIndex: _currentQuestionIndex,
                    incrementQuestionIndexFunc: incrementQuestionIndex,
                    updateAnswersFunc: updateAnswers,
                    recommendationPrompt: recommendationPrompts[_currentQuestionIndex],
                  ),
            Spacer(),
            RecommendationButton(
              incrementQuestionIndexFunc: incrementQuestionIndex,
              currentQuestionIndex: _currentQuestionIndex,
              answers: answers,
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  void incrementQuestionIndex() {
    if (_currentQuestionIndex < recommendationPrompts.length - 1) {
      _currentQuestionIndex++;
      setState(() {});
    }
  }

  void updateAnswers(currentQuestionIndex, answer) {
    answers[currentQuestionIndex] = answer;
    setState(() {});
  }
}
