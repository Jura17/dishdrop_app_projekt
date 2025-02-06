import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/repositories/database_repository.dart';

class RecipeController {
  final DatabaseRepository _databaseRepository;
  RecipeController(this._databaseRepository);

  List<Recipe> getAllRecipes() => _databaseRepository.getAllRecipes();
  void addRecipe(Recipe newRecipe) => _databaseRepository.addRecipe(newRecipe);
  void removeRecipe(int id) => _databaseRepository.removeRecipe(id);
}
