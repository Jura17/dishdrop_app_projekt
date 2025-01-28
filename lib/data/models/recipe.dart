import 'list_item.dart';

class Recipe {
  String title;
  String category;
  String difficulty;
  Map<String, dynamic> images = {
    "titleImg": "",
    "directionImg": [],
  };
  int prepTime;
  int cookTime;
  int timesCooked = 0;
  List<String> directions = [];
  List<ListItem> ingredients = [];

  Recipe(
      {required this.title,
      required this.category,
      required this.difficulty,
      required this.prepTime,
      required this.cookTime});

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
    return cookTime;
  }

  int getTotalTime() {
    return prepTime + cookTime;
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

  void setCookTime(int newCookTime) {
    cookTime = newCookTime;
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
