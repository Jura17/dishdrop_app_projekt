import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:dishdrop_app_projekt/data/models/recommendation_prompt.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recommendation_screen_widgets/answer_button.dart';

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
    // Get the list of enabled (clickable) options from the prompt
    final enabledOptions = recommendationPrompt.enabledOptions;

    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 2.4,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      shrinkWrap: true,
      children: [
        ...recommendationPrompt.options.entries.map(
          (answer) {
            final isEnabled = enabledOptions.contains(answer.value);

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: AnswerButton(
                isEnabled: isEnabled,
                updateAnswersFunc: updateAnswersFunc,
                currentQuestionIndex: currentQuestionIndex,
                answer: answer,
                // optionValue: answerValue,
                incrementQuestionIndexFunc: incrementQuestionIndexFunc,
                // optionText: answerText,
              ),
            );
          },
        )
      ],
    );
  }
}
