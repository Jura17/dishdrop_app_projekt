import 'package:dishdrop_app_projekt/core/utils/get_random_recipe.dart';
import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/provider/recipe_notifier.dart';
import 'package:dishdrop_app_projekt/data/repositories/recommendation_data.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_search/filter_recipe.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recommendation_button.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recommendation_card_view_widgets/entry_prompt_view.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recommendation_card_view_widgets/prompt_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
              resetQuestions: resetPrompts,
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

  void resetPrompts() {
    _currentQuestionIndex = -1;
    answers.clear();
    setState(() {});
  }

  void updateAnswers(int currentQuestionIndex, Enum answer) {
    answers[currentQuestionIndex] = answer;

    if (currentQuestionIndex < recommendationPrompts.length - 1) {
      final nextIndex = currentQuestionIndex + 1;
      final allRecipes = context.read<RecipeNotifier>().allRecipes;

      final enabledOptions = getValidOptionsForQuestion(
        questionIndex: nextIndex,
        allRecipes: allRecipes,
        currentAnswers: answers,
        allOptions: recommendationPrompts[nextIndex].options.entries.toList(),
      );

      setState(() {
        recommendationPrompts[nextIndex].enabledOptions = enabledOptions;
      });
    } else {
      // All questions answered -> pick recipe
      final finalFiltered = filterRecipes(context.read<RecipeNotifier>().allRecipes, answers);

      getRandomRecipe(context, finalFiltered.isNotEmpty ? finalFiltered : context.read<RecipeNotifier>().allRecipes);
      resetPrompts();
    }

    setState(() {});
  }

  Set<Enum> getValidOptionsForQuestion({
    required int questionIndex,
    required List<Recipe> allRecipes,
    required Map<int, Enum> currentAnswers,
    required List<MapEntry<String, Enum>> allOptions,
  }) {
    final validOptions = <Enum>{};

    for (final option in allOptions) {
      final tempAnswers = Map<int, Enum>.from(currentAnswers);
      tempAnswers[questionIndex] = option.value;

      final result = filterRecipes(allRecipes, tempAnswers);
      if (result.isNotEmpty) {
        validOptions.add(option.value);
      }
    }

    return validOptions;
  }
}
