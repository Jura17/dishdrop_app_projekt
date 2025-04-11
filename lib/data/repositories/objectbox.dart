import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:dishdrop_app_projekt/data/models/shopping_list.dart';
import 'package:dishdrop_app_projekt/data/repositories/recipe_mock_data.dart';
import 'package:dishdrop_app_projekt/objectbox.g.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class ObjectBox {
  late final Store store;
  late final Box<Recipe> recipeBox;
  late final Box<ShoppingList> shoppingList;

  ObjectBox._create(this.store) {
    recipeBox = Box<Recipe>(store);
    shoppingList = Box<ShoppingList>(store);
    // if (recipeBox.isEmpty()) recipeBox.putMany(recipeData);
  }

  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final store = openStore(directory: p.join(docsDir.path, "dishdrop-app-store"));
    return ObjectBox._create(store);
  }
}
