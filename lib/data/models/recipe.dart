class Recipe {
  String title;
  String category;
  String difficulty;
  Map<String, dynamic> images;
  int prepTime;
  int cookTime;
  int timesCooked = 0;
  List<String> directions;
  List<String> ingredients;

  Recipe({
    required this.title,
    required this.category,
    required this.difficulty,
    required this.images,
    required this.prepTime,
    required this.cookTime,
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

  // TODO: aus dem String sollte ein ListItem gemacht werden, bevor es ingredients hinzugefügt wird
  void addIngredient(String newIngredient) {
    ingredients.add(newIngredient);
  }

// TODO: aus dem String sollte ein ListItem gemacht werden, bevor es ingredients hinzugefügt wird
  void setIngredient(int index, String newIngredient) {
    ingredients[index] = newIngredient;
  }

  void removeIngredient(int index) {
    ingredients.removeAt(index);
  }
}
