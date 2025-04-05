import 'package:dishdrop_app_projekt/data/models/cooking_direction.dart';
import 'package:dishdrop_app_projekt/data/models/list_item.dart';
import 'package:objectbox/objectbox.dart';

@Entity
class Recipe {
  @Id()
  int id = 0;

  String title;
  String category;
  String description;
  String notes;
  String difficulty;
  List<String> tags;
  Map<String, dynamic> images;
  int prepTime;
  int cookingTime;
  int timesCooked = 0;
  bool isFavorite = false;

  @Backlink()
  final ToMany<CookingDirection> directions = ToMany<CookingDirection>();

  @Backlink()
  final ToMany<ListItem> ingredients = ToMany<ListItem>();

  // ! before objectbox:
  // List<CookingDirection> directions;
  // List<ListItem> ingredients;
  // TODO: ingredients probably needs to be a map so I can have ingredient group titles
  /*
  ingredients = {
  "chicken" : [a, b, c],
  "sauce" : [d, e, f]
  }
   */

  Recipe({
    this.id = 0,
    required this.title,
    required this.category,
    required this.description,
    required this.notes,
    required this.difficulty,
    required this.tags,
    required this.images,
    required this.prepTime,
    required this.cookingTime,
  });
}
