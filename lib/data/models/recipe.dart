import 'package:dishdrop_app_projekt/data/models/list_item.dart';

class Recipe {
  String title;
  String category;
  String description;
  String difficulty;
  List<String> tags;
  Map<String, dynamic> images;
  int prepTime;
  int cookingTime;
  int timesCooked = 0;
  List<String> directions;
  // TODO: ingredients probably needs to be a map so I can have ingredient group titles
  List<ListItem> ingredients;
  bool isFavorite = false;

  Recipe({
    required this.title,
    required this.category,
    required this.description,
    required this.difficulty,
    required this.tags,
    required this.images,
    required this.prepTime,
    required this.cookingTime,
    required this.directions,
    required this.ingredients,
  });

  String getTitle() {
    return title;
  }

  String getDifficulty() {
    return difficulty;
  }

  int getPrepTime() {
    return prepTime;
  }

  int getCookTime() {
    return cookingTime;
  }

  int getTotalTime() {
    return prepTime + cookingTime;
  }

  int getTimesCooked() {
    return timesCooked;
  }

  void setTitle(String newTitle) {
    title = newTitle;
  }

  void setDifficulty(String newDifficulty) {
    difficulty = newDifficulty;
  }

  void setPrepTime(int newPrepTime) {
    prepTime = newPrepTime;
  }

  void setCookingTime(int newCookingTime) {
    cookingTime = newCookingTime;
  }

  void increaseTimesCooked() {
    timesCooked++;
  }

  void addDirection(String newDirection) {
    directions.add(newDirection);
  }

  void setDirection(int index, String newDirectionText) {
    directions[index] = newDirectionText;
  }

  void removeDirection(int index) {
    directions.removeAt(index);
  }

  void addIngredient(ListItem newIngredient) {
    ingredients.add(newIngredient);
  }

  void setIngredient(int index, ListItem newIngredient) {
    ingredients[index] = newIngredient;
  }

  void removeIngredient(int index) {
    ingredients.removeAt(index);
  }
}
