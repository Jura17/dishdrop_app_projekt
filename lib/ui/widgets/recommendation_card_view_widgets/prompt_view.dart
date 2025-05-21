import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:dishdrop_app_projekt/data/models/recommendation_prompt.dart';

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

    return Column(
      children: [
        Text(
          recommendationPrompt.question,
          style: Theme.of(context).textTheme.headlineLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Column(
          children: recommendationPrompt.options.entries.map((entry) {
            final optionText = entry.key;
            final optionValue = entry.value;

            final isEnabled = enabledOptions.contains(optionValue);

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: ElevatedButton(
                onPressed: isEnabled
                    ? () {
                        updateAnswersFunc(currentQuestionIndex, optionValue);
                        incrementQuestionIndexFunc();
                      }
                    // Disable the button if not enabled
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isEnabled ? AppColors.lightGreen : Colors.grey.shade400,
                  foregroundColor: isEnabled ? AppColors.primary : Colors.white,
                ),
                child: Text(optionText),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
