import '../repositories/recipe_repository.dart';
import '../entities/recipe.dart';

class AddRecipe {
  final RecipeRepository repository;

  AddRecipe(this.repository);

  Future<void> call(Recipe recipe) async {
    await repository.addRecipe(recipe);
  }
}
