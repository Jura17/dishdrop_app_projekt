import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/models/shopping_list.dart';
import 'package:dishdrop_app_projekt/data/repositories/database_repository.dart';
import 'package:flutter/material.dart';

class RecipeNotifier extends ChangeNotifier {
  final DatabaseRepository _databaseRepository;
  List<Recipe> _filteredRecipes = [];

  RecipeNotifier(this._databaseRepository);

  List<Recipe> get allRecipes {
    return _databaseRepository.getAllRecipes();
  }

  void updateFilteredRecipe(List<Recipe> filteredRecipes) {
    _filteredRecipes = filteredRecipes;
    notifyListeners();
  }

  List<Recipe> get filteredRecipes => _filteredRecipes;

  void addRecipe(Recipe newRecipe) {
    _databaseRepository.addRecipe(newRecipe);
    notifyListeners();
  }

  Recipe? getRecipeById(int id) {
    return _databaseRepository.getRecipeById(id);
  }

  void assignShoppingListToRecipe(Recipe recipe, ShoppingList shoppingList) {
    _databaseRepository.assignShoppingListToRecipe(recipe, shoppingList);
    notifyListeners();
  }

  void removeRecipe(Recipe recipe) {
    _databaseRepository.removeRecipe(recipe);
    notifyListeners();
  }

  void updateRecipe(int id, Recipe recipe) {
    _databaseRepository.updateRecipe(id, recipe);
    notifyListeners();
  }
}
