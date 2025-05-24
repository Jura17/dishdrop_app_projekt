import 'package:dishdrop_app_projekt/core/utils/get_random_recipe.dart';
import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/provider/recipe_notifier.dart';
import 'package:dishdrop_app_projekt/data/repositories/recommendation_data.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recommendation_screen_widgets/filter_recipe.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recommendation_screen_widgets/recommendation_button.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recommendation_screen_widgets/entry_prompt_view.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recommendation_screen_widgets/prompt_view.dart';
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
  int currentQuestionIndex = -1;
  // the size of 'answers' is fixed to the number of questions we have
  // and pre-filled with null-values for unanswered questions so we can always safely assign values
  List<Enum?> answers = List.filled(recommendationPrompts.length, null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (currentQuestionIndex >= 0)
              Text(
                recommendationPrompts[currentQuestionIndex].question,
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
            Spacer(),
            currentQuestionIndex < 0
                ? EntryPromptView()
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: PromptView(
                      currentQuestionIndex: currentQuestionIndex,
                      incrementQuestionIndexFunc: incrementQuestionIndex,
                      updateAnswersFunc: updateAnswers,
                      recommendationPrompt: recommendationPrompts[currentQuestionIndex],
                    ),
                  ),
            SizedBox(height: 40),
            RecommendationButton(
              incrementQuestionIndexFunc: incrementQuestionIndex,
              currentQuestionIndex: currentQuestionIndex,
              answers: answers,
              resetQuestions: resetPrompts,
            ),
            if (currentQuestionIndex < 0) Spacer(),
            SizedBox(height: 50)
          ],
        ),
      ),
    );
  }

  void incrementQuestionIndex() {
    if (currentQuestionIndex < recommendationPrompts.length - 1) {
      currentQuestionIndex++;
      setState(() {});
    }
  }

  void resetPrompts() {
    currentQuestionIndex = -1;
    answers = List.filled(recommendationPrompts.length, null);
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
      final finalFiltered = filterRecipes(
        context.read<RecipeNotifier>().allRecipes,
        answers,
        context,
      );

      getRandomRecipe(
        context,
        finalFiltered.isNotEmpty ? finalFiltered : context.read<RecipeNotifier>().allRecipes,
      );
      resetPrompts();
    }

    setState(() {});
  }

  Set<Enum> getValidOptionsForQuestion({
    required int questionIndex,
    required List<Recipe> allRecipes,
    required List<Enum?> currentAnswers,
    required List<MapEntry<String, Enum>> allOptions,
  }) {
    final validOptions = <Enum>{};

    for (final option in allOptions) {
      // create a shallow copy of currentAnswers instead using the same list
      final tempAnswers = List<Enum?>.from(currentAnswers);
      tempAnswers[questionIndex] = option.value;

      final result = filterRecipes(allRecipes, tempAnswers, context);
      if (result.isNotEmpty) {
        validOptions.add(option.value);
      }
    }

    return validOptions;
  }
}
