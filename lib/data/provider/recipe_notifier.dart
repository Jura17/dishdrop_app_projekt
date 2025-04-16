import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/repositories/database_repository.dart';
import 'package:flutter/material.dart';

class RecipeNotifier extends ChangeNotifier {
  final DatabaseRepository _databaseRepository;

  RecipeNotifier(this._databaseRepository);

  List<Recipe> get allRecipes {
    return _databaseRepository.getAllRecipes();
  }

  void addRecipe(Recipe newRecipe) {
    _databaseRepository.addRecipe(newRecipe);
    notifyListeners();
  }

  void removeRecipe(Recipe recipe) {
    _databaseRepository.removeRecipe(recipe);
    notifyListeners();
  }

  void updateRecipe(Recipe recipe) {
    _databaseRepository.updateRecipe(recipe);
    notifyListeners();
  }
}
