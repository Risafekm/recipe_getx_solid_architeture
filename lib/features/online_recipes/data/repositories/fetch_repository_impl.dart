import 'package:recipes_solid/features/online_recipes/data/datasources/fetch_recipe_data_source.dart';
import 'package:recipes_solid/features/online_recipes/domain/entities/fetch_entity.dart';
import 'package:recipes_solid/features/online_recipes/domain/repositories/fetch_repository.dart';

class FetchRepositoryImpl implements FetchRepository {
  FetchRecipeDataSource fetchRecipeDataSource;

  FetchRepositoryImpl({required this.fetchRecipeDataSource});

  @override
  Future<List<FetchEntity>> getFetchRecipe() async {
    final fetchRecipe = await fetchRecipeDataSource.loadFetchRecipes();
    return fetchRecipe.map((model) => model.toEntity()).toList();
  }
}
