import 'dart:convert';

import 'package:dishdrop_app_projekt/data/models/cooking_direction.dart';
import 'package:dishdrop_app_projekt/data/models/list_item.dart';
import 'package:dishdrop_app_projekt/data/models/shopping_list.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Recipe {
  @Id()
  int id = 0;

  String title;
  String category;
  String description;
  String notes;
  String difficulty;
  List<String> tags;
  String imagesJson;
  int prepTime;
  int cookingTime;
  int timesCooked = 0;
  bool isFavorite = false;

  final ToOne<ShoppingList> shoppingList = ToOne<ShoppingList>();

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
    required this.imagesJson,
    required this.tags,
    required this.prepTime,
    required this.cookingTime,
  });

  Map<String, dynamic> get images => jsonDecode(imagesJson);
  void setImages(Map<String, dynamic> newImages) {
    imagesJson = jsonEncode(newImages);
  }

  // -------------------------------

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'category': category,
      // ...
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      title: map['title'],
      category: map['category'],
      description: map['description'],
      notes: map['notes'],
      difficulty: map['difficulty'],
      imagesJson: map['imagesJson'],
      tags: map['tags'],
      prepTime: map['prepTime'],
      cookingTime: map['cookingTime'],
    );
  }

  void updateCounterTimesCooked() {
    timesCooked++;
  }

  void toggleIsFavorite() {
    isFavorite = !isFavorite;
  }
}
