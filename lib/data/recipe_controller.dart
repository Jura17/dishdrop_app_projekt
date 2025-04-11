import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/repositories/database_repository.dart';

class RecipeController {
  final DatabaseRepository _databaseRepository;
  RecipeController(this._databaseRepository);

  // Future<List<Recipe>> getAllRecipes() => Future.delayed(
  //       Duration(seconds: 2),
  //       () => _databaseRepository.getAllRecipes(),
  //     );

  // Future<void> addRecipe(Recipe newRecipe) => Future.delayed(
  //       Duration(seconds: 2),
  //       () => _databaseRepository.addRecipe(newRecipe),
  //     );

  // Future<void> removeRecipe(Recipe recipe) => Future.delayed(
  //       Duration(seconds: 2),
  //       () => _databaseRepository.removeRecipe(recipe),
  //     );

  // Future<void> updateRecipe(Recipe oldRecipe, Recipe newRecipe) => Future.delayed(
  //       Duration(seconds: 2),
  //       () => _databaseRepository.updateRecipe(oldRecipe, newRecipe),
  //     );

  Stream<List<Recipe>> getAllRecipes() => _databaseRepository.getAllRecipes();
  void addRecipe(Recipe newRecipe) => _databaseRepository.addRecipe(newRecipe);
  void removeRecipe(Recipe recipe) => _databaseRepository.removeRecipe(recipe);
  void updateRecipe(Recipe oldRecipe, Recipe newRecipe) => _databaseRepository.updateRecipe(oldRecipe, newRecipe);
}
