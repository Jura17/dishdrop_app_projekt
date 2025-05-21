import 'package:dishdrop_app_projekt/data/models/recommendation_prompt.dart';

enum CategoriesPreference { appetizers, mainCourses, sideDishes, salads, sweetStuff, drinks }

enum DifficultyPreference { simple, notTooTricky, impressive, irrelevant }

enum TimePreference { little, medium, irrelevant }

enum FamiliarityPreference { familiar, unfamiliar, veryFamiliar, irrelevant }

enum FavoriteRecipePreference { onlyFavorites, excludeFavorites, irrelevant }

final List<RecommendationPrompt> recommendationPrompts = [
  RecommendationPrompt(
    question: "What category are you looking for?",
    options: {
      "Appetizers": CategoriesPreference.appetizers,
      "Main Courses": CategoriesPreference.mainCourses,
      "Side Dishes": CategoriesPreference.sideDishes,
      "Salads": CategoriesPreference.salads,
      "Sweet Stuff": CategoriesPreference.sweetStuff,
      "Drinks": CategoriesPreference.drinks,
    },
  ),
  RecommendationPrompt(
    question: "What difficulty shall it be?",
    options: {
      "A simple one": DifficultyPreference.simple,
      "Not too tricky": DifficultyPreference.notTooTricky,
      "Something impressive": DifficultyPreference.impressive,
      "Anything works": DifficultyPreference.irrelevant,
    },
  ),
  RecommendationPrompt(
    question: "How much time do you have?",
    options: {
      "30 minutes max": TimePreference.little,
      "Not more than one hour": TimePreference.medium,
      "Time doesn't matter": TimePreference.irrelevant
    },
  ),
  RecommendationPrompt(
    question: "Something you have tried before? A new recipe maybe?",
    options: {
      "Give me something fresh": FamiliarityPreference.unfamiliar,
      "Something I've cooked before": FamiliarityPreference.familiar,
      "One that I've cooked a lot": FamiliarityPreference.veryFamiliar,
      "I don't care": FamiliarityPreference.irrelevant,
    },
  ),
  RecommendationPrompt(
    question: "Do you want one of your favorites?",
    options: {
      "Yeah, favorites only": FavoriteRecipePreference.onlyFavorites,
      "None-favorites, please": FavoriteRecipePreference.excludeFavorites,
      "Doesn't matter": FavoriteRecipePreference.irrelevant,
    },
  )
];
