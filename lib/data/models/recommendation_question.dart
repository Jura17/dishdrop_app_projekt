class RecommendationPrompt {
  final String question;
  final Map<String, Enum> options;

  RecommendationPrompt({
    required this.question,
    required this.options,
  });
}
