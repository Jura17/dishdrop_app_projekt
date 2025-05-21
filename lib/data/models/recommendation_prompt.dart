class RecommendationPrompt {
  final String question;
  final Map<String, Enum> options;
  Set<Enum> enabledOptions;
  /* using Set instead of List here because: 
  - checking only for membership (does entry xy exist in this group?) -> cleaner intent
  - time complexity average is 0(1) instead of 0(n) worst-case with lists
  */

  RecommendationPrompt({
    required this.question,
    required this.options,
    Set<Enum>? enabledOptions,
  }) : enabledOptions = enabledOptions ?? options.values.toSet();
}
