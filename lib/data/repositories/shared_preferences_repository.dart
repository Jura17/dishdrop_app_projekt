import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesRepository {
  final String _addRecipeFormKey = "addRecipeForm";
  final String _editRecipeFormKey = "editRecipeForm";

  late final Future<SharedPreferences> _prefsFuture;

  SharedPreferencesRepository() {
    _prefsFuture = SharedPreferences.getInstance();
  }

  Future<void> overrideCachedInput(String formInputJsonString) async {
    final prefs = await _prefsFuture;
    await prefs.setString(_addRecipeFormKey, formInputJsonString);
  }

  Future<String> get cachedInput async {
    final prefs = await _prefsFuture;
    return prefs.getString(_addRecipeFormKey) ?? '';
  }

  Future<void> deleteCachedInput() async {
    final prefs = await _prefsFuture;
    await prefs.remove(_addRecipeFormKey);
  }

  Future<void> overrideCachedEditInput(String formInputJsonString) async {
    final prefs = await _prefsFuture;
    await prefs.setString(_editRecipeFormKey, formInputJsonString);
  }

  Future<String> get cachedEditInput async {
    final prefs = await _prefsFuture;
    return prefs.getString(_editRecipeFormKey) ?? '';
  }

  Future<void> deleteCachedEditInput() async {
    final prefs = await _prefsFuture;
    await prefs.remove(_editRecipeFormKey);
  }
}
