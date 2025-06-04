import 'package:dishdrop_app_projekt/data/models/recommendation_prompt.dart';

enum CategoriesPreference { appetizers, mainCourses, sideDishes, salads, sweetStuff, drinks }

enum DifficultyPreference { simple, notTooTricky, impressive, irrelevant }

enum TimePreference { veryLittle, little, medium, irrelevant }

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
    question: "Choose a difficulty",
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
      "15 minutes": TimePreference.veryLittle,
      "30 minutes": TimePreference.little,
      "Not more than one hour": TimePreference.medium,
      "Time doesn't matter": TimePreference.irrelevant
    },
  ),
  RecommendationPrompt(
    question: "A recipe you have tried before? A new one maybe?",
    options: {
      "Give me a new one": FamiliarityPreference.unfamiliar,
      "Something I've cooked before": FamiliarityPreference.familiar,
      "One that I've cooked a lot": FamiliarityPreference.veryFamiliar,
      "I don't care": FamiliarityPreference.irrelevant,
    },
  ),
  RecommendationPrompt(
    question: "Do you want one of your favorites?",
    options: {
      "Favorites only": FavoriteRecipePreference.onlyFavorites,
      "None-favorites": FavoriteRecipePreference.excludeFavorites,
      "Doesn't matter": FavoriteRecipePreference.irrelevant,
    },
  )
];
