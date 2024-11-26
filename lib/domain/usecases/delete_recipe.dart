import '../repositories/recipe_repository.dart';

class DeleteRecipe {
  final RecipeRepository repository;

  DeleteRecipe(this.repository);

  Future<void> call(String id) async {
    await repository.deleteRecipe(id);
  }
}
