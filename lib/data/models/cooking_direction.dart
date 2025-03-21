class CookingDirection {
  String id;
  String description;

  CookingDirection({
    required this.id,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
    };
  }
}
