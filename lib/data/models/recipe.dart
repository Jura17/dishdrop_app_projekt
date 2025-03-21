import 'package:dishdrop_app_projekt/data/models/cooking_direction.dart';
import 'package:dishdrop_app_projekt/data/models/list_item.dart';

class Recipe {
  String id;
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
  List<CookingDirection> directions;
  // TODO: ingredients probably needs to be a map so I can have ingredient group titles
  List<ListItem> ingredients;
  bool isFavorite = false;

  Recipe({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.notes,
    required this.difficulty,
    required this.tags,
    required this.images,
    required this.prepTime,
    required this.cookingTime,
    required this.directions,
    required this.ingredients,
  });
}
