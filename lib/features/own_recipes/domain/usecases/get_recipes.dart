import '../repositories/recipe_repository.dart';
import '../entities/recipe.dart';

class GetRecipes {
  final RecipeRepository repository;

  GetRecipes(this.repository);

  Future<List<Recipe>> call() async {
    return await repository.getRecipes();
  }
}
