import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesRepository {
  final String _recipeFormKey = "recipeForm";

  late final Future<SharedPreferences> _prefsFuture;

  SharedPreferencesRepository() {
    _prefsFuture = SharedPreferences.getInstance();
  }

  Future<void> overrideCachedInput(String formInputJsonString) async {
    final prefs = await _prefsFuture;
    await prefs.setString(_recipeFormKey, formInputJsonString);
  }

  Future<String> get cachedInput async {
    final prefs = await _prefsFuture;
    return prefs.getString(_recipeFormKey) ?? '';
  }

  Future<void> deleteCachedInput() async {
    final prefs = await _prefsFuture;
    await prefs.remove(_recipeFormKey);
  }
}
