// recipe_repository_impl.dart

import '../../domain/entities/recipe.dart';
import '../../domain/repositories/recipe_repository.dart';
import '../datasources/recipe_local_data_source.dart';
import '../models/recipe_model.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeLocalDataSource localDataSource;

  RecipeRepositoryImpl(this.localDataSource);

  @override
  Future<void> addRecipe(Recipe recipe) async {
    final recipeModel = RecipeModel.fromEntity(recipe); // Convert to model
    await localDataSource.addRecipe(recipeModel); // Store in local data source
  }

  @override
  Future<List<Recipe>> getRecipes() async {
    final recipeModels = await localDataSource
        .loadRecipes(); // Ensure these are RecipeModel instances
    return recipeModels.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> deleteRecipe(String id) async {
    await localDataSource.deleteRecipe(id); // Delete from local data source
  }

  @override
  Future<void> saveOrder(List<Recipe> recipes) async {
    final models =
        recipes.map((recipe) => RecipeModel.fromEntity(recipe)).toList();
    await localDataSource.saveRecipeOrder(models);
  }
}
