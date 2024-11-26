import '../entities/recipe.dart';

abstract class RecipeRepository {
  Future<void> addRecipe(Recipe recipe);

  Future<List<Recipe>> getRecipes();

  Future<void> deleteRecipe(String id);
}
