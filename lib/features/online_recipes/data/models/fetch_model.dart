import '../../domain/entities/fetch_entity.dart';

class FetchModel {
  final String id;
  final String name;
  final String imageUrl;
  final String cookingTime;
  final String ingredients;
  final String making;

  FetchModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.cookingTime,
    required this.ingredients,
    required this.making,
  });

  // Convert JSON to Model
  factory FetchModel.fromJson(Map<String, dynamic> json) {
    return FetchModel(
      id: json['id'] ?? 'unknown',
      name: json['name'] ?? 'No Name',
      imageUrl: json['imageUrl'] ?? 'assets/no_image.png',
      cookingTime: json['cookingTime'] ?? 'Unknown',
      ingredients: json['ingredients'] ?? 'No Ingredients',
      making: json['making'] ?? 'No Instructions',
    );
  }

  // Convert Model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'cookingTime': cookingTime,
      'ingredients': ingredients,
      'making': making,
    };
  }

  // Convert Model to Entity
  FetchEntity toEntity() {
    return FetchEntity(
      id: id,
      name: name,
      imageUrl: imageUrl,
      cookingTime: cookingTime,
      ingredients: ingredients,
      making: making,
    );
  }

  // Create Model from Entity
  factory FetchModel.fromEntity(FetchEntity entity) {
    return FetchModel(
      id: entity.id,
      name: entity.name,
      imageUrl: entity.imageUrl,
      cookingTime: entity.cookingTime,
      ingredients: entity.ingredients,
      making: entity.making,
    );
  }
}
