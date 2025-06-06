import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:dishdrop_app_projekt/core/utils/get_random_recipe.dart';
import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/provider/recipe_notifier.dart';

import 'package:dishdrop_app_projekt/ui/widgets/recommendation_screen_widgets/filter_recipe.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecommendationButton extends StatefulWidget {
  const RecommendationButton({
    super.key,
    required this.incrementQuestionIndexFunc,
    required this.currentQuestionIndex,
    required this.resetQuestions,
    required this.answers,
  });

  final Function incrementQuestionIndexFunc;
  final Function resetQuestions;
  final int currentQuestionIndex;
  final List<Enum?> answers;

  @override
  State<RecommendationButton> createState() => _RecommendationButtonState();
}

class _RecommendationButtonState extends State<RecommendationButton> {
  late List<Recipe> allRecipes;
  late List<Recipe> filteredRecipes;
  bool showStartOverButton = false;

  @override
  void initState() {
    super.initState();
    allRecipes = context.read<RecipeNotifier>().allRecipes;
    filteredRecipes = allRecipes;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton.icon(
          label: widget.currentQuestionIndex < 0
              ? Text(
                  "Start here",
                  style: TextStyle(fontWeight: FontWeight.w500),
                )
              : Text("Just give me something"),
          icon: Icon(
            Icons.lightbulb_outline_rounded,
            color: widget.currentQuestionIndex < 0 ? Colors.white : AppColors.primary,
          ),
          style: ButtonStyle(
              iconSize: WidgetStateProperty.all(30),
              backgroundColor: widget.currentQuestionIndex < 0 ? WidgetStateProperty.all(AppColors.primary) : null,
              foregroundColor: widget.currentQuestionIndex < 0
                  ? WidgetStateProperty.all(Colors.white)
                  : WidgetStateProperty.all(AppColors.primary)),
          onPressed: () {
            // if current index is < 0 we haven't started yet and increment the index
            // else we go through all recipes and filter them by answer
            if (widget.currentQuestionIndex < 0) {
              widget.incrementQuestionIndexFunc();
              return;
            }

            final filtered = filterRecipes(allRecipes, widget.answers, context);

            if (filtered.isEmpty) {
              getRandomRecipe(context, allRecipes);
            } else {
              getRandomRecipe(context, filtered);
            }

            widget.resetQuestions();
          },
        ),
        if (widget.currentQuestionIndex >= 0)
          TextButton.icon(
            label: Text("Start over"),
            icon: Icon(Icons.replay_outlined),
            style: ButtonStyle(
              iconSize: WidgetStateProperty.all(30),
              foregroundColor: WidgetStateProperty.all(Colors.red),
            ),
            onPressed: () => widget.resetQuestions(),
          ),
      ],
    );
  }
}
