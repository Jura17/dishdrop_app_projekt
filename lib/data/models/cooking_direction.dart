import 'package:dishdrop_app_projekt/data/models/recipe.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class CookingDirection {
  @Id()
  int id = 0;

  String description;

  final ToOne<Recipe> recipe = ToOne<Recipe>();

  CookingDirection({
    this.id = 0,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
    };
  }
}
