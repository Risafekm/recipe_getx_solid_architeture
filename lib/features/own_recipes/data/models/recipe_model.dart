import 'package:hive_flutter/hive_flutter.dart';

import '../../domain/entities/recipe.dart';

part 'recipe_model.g.dart';

@HiveType(typeId: 1)
class RecipeModel extends Recipe {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String imageUrl;

  @HiveField(4)
  final String cookingTime;

  @HiveField(5)
  final String ingredients;

  RecipeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.cookingTime,
    required this.ingredients,
  }) : super(
          id: id,
          title: title,
          description: description,
          imageUrl: imageUrl,
          cookingTime: cookingTime,
          ingredients: ingredients,
        );

  factory RecipeModel.fromEntity(Recipe recipe) {
    return RecipeModel(
      id: recipe.id,
      title: recipe.title,
      description: recipe.description,
      imageUrl: recipe.imageUrl,
      cookingTime: recipe.cookingTime,
      ingredients: recipe.ingredients,
    );
  }

  Recipe toEntity() {
    return Recipe(
      id: id,
      title: title,
      description: description,
      imageUrl: imageUrl,
      cookingTime: cookingTime,
      ingredients: ingredients,
    );
  }
}
