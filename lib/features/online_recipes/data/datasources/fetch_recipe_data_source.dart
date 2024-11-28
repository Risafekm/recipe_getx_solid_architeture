import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:recipes_solid/features/online_recipes/data/models/fetch_model.dart';
import 'package:http/http.dart' as http;

abstract class FetchRecipeDataSource {
  Future<List<FetchModel>> loadFetchRecipes();
}

class FetchRecipeDataSourceImpl implements FetchRecipeDataSource {
  @override
  Future<List<FetchModel>> loadFetchRecipes() async {
    const api =
        "https://recipe-risaf.muhammedhafiz.com/recipe_project/recipe/read_recipe.php";
    try {
      final response =
          await http.get(Uri.parse(api)).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        // debugPrint('Response JSON: $jsonData');
        return (jsonData as List)
            .map((recipeJson) => FetchModel.fromJson(recipeJson))
            .toList();
      } else {
        // Log more details about the failure
        debugPrint(
            'Error: Failed to load recipes. Status code: ${response.statusCode}');
        throw Exception('Failed to load recipes');
      }
    } catch (error) {
      debugPrint('Error: $error');
      throw Exception('Failed to load recipes: $error');
    }
  }
}
