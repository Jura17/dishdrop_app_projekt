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

    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 2.4,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      shrinkWrap: true,
      children: [
        ...recommendationPrompt.options.entries.map(
          (entry) {
            final optionText = entry.key;
            final optionValue = entry.value;

            final isEnabled = enabledOptions.contains(optionValue);
            const infoSnackBar = SnackBar(content: Text("No such recipes found"));

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: ElevatedButton(
                onPressed: isEnabled
                    ? () {
                        // update map holding given answers and check available options for next prompt
                        updateAnswersFunc(currentQuestionIndex, optionValue);
                        incrementQuestionIndexFunc();
                      }
                    : () {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(infoSnackBar);
                        }
                        return;
                      },
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  backgroundColor: isEnabled ? AppColors.primary : Color(0xFFE0E0E0),
                  foregroundColor: isEnabled ? Colors.white : Color(0xFF9E9E9E),
                  shadowColor: isEnabled ? Color.fromARGB(255, 38, 47, 40) : Color.fromARGB(0, 214, 214, 214),
                ),
                child: Text(
                  optionText,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
