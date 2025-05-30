import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  const AnswerButton({
    super.key,
    required this.isEnabled,
    required this.updateAnswersFunc,
    required this.currentQuestionIndex,
    required this.incrementQuestionIndexFunc,
    required this.answer,
  });

  final bool isEnabled;
  final Function updateAnswersFunc;
  final int currentQuestionIndex;
  final Function incrementQuestionIndexFunc;
  final MapEntry<String, Enum> answer;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnabled
          ? () {
              // update map holding given answers and check available options for next prompt
              updateAnswersFunc(currentQuestionIndex, answer.value);
              incrementQuestionIndexFunc();
            }
          : () {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("No such recipes found"),
                  ),
                );
              }
              return;
            },
      style: ElevatedButton.styleFrom(
        textStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
        backgroundColor: isEnabled ? AppColors.lightGreen : Color(0xFFE0E0E0),
        foregroundColor: isEnabled ? AppColors.primary : Color(0xFF9E9E9E),
        shadowColor: isEnabled ? Color.fromARGB(255, 38, 47, 40) : Color.fromARGB(0, 214, 214, 214),
      ),
      child: Text(
        answer.key,
        textAlign: TextAlign.center,
      ),
    );
  }
}
