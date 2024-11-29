import 'package:hive/hive.dart';
import '../models/recipe_model.dart';

abstract class RecipeLocalDataSource {
  Future<void> addRecipe(RecipeModel recipe);
  Future<List<RecipeModel>> loadRecipes();
  Future<void> deleteRecipe(String id);

  // New method to save the order
  Future<void> saveRecipeOrder(List<RecipeModel> orderedRecipes);
}

class RecipeLocalDataSourceImpl implements RecipeLocalDataSource {
  final Box<RecipeModel> recipeBox;

  RecipeLocalDataSourceImpl(this.recipeBox);

  @override
  Future<void> addRecipe(RecipeModel recipe) async {
    await recipeBox.put(recipe.id, recipe);
  }

  @override
  Future<List<RecipeModel>> loadRecipes() async {
    return recipeBox.values.toList();
  }

  @override
  Future<void> deleteRecipe(String id) async {
    await recipeBox.delete(id);
  }

  @override
  Future<void> saveRecipeOrder(List<RecipeModel> orderedRecipes) async {
    await recipeBox.clear(); // Clear the box before saving the new order
    for (var recipe in orderedRecipes) {
      await recipeBox.put(recipe.id, recipe);
    }
  }
}
