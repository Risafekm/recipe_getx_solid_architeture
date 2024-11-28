import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../features/grocery_items_listing/data/datasources/grocery_local_data_source.dart';
import '../../features/grocery_items_listing/data/models/grocery_model.dart';
import '../../features/grocery_items_listing/data/repositories/grocery_repository_impl.dart';
import '../../features/grocery_items_listing/domain/usecases/add_grocery_usecase.dart';
import '../../features/grocery_items_listing/domain/usecases/delete_grocery_usecase.dart';
import '../../features/grocery_items_listing/domain/usecases/get_grocery_usecase.dart';
import '../../features/grocery_items_listing/domain/usecases/update_grocery_usecase.dart';
import '../../features/online_recipes/data/datasources/fetch_recipe_data_source.dart';
import '../../features/online_recipes/data/repositories/fetch_repository_impl.dart';
import '../../features/online_recipes/domain/usecases/get_fetch_recipe_usecase.dart';
import '../../features/own_recipes/data/datasources/recipe_local_data_source.dart';
import '../../features/own_recipes/data/models/recipe_model.dart';
import '../../features/own_recipes/data/repositories/recipe_repository_imp.dart';
import '../../features/own_recipes/domain/usecases/add_recipe.dart';
import '../../features/own_recipes/domain/usecases/delete_recipe.dart';
import '../../features/own_recipes/domain/usecases/get_recipes.dart';

// Create an instance of GetIt
final getIt = GetIt.instance;

// Register all your services here
void setup() {
  // Register services for own recipes
  final recipeBox = Hive.box<RecipeModel>('recipes');
  final localDataSource = RecipeLocalDataSourceImpl(recipeBox);
  final repository = RecipeRepositoryImpl(localDataSource);
  final getRecipesUseCase = GetRecipes(repository);
  final addRecipeUseCase = AddRecipe(repository);
  final deleteRecipeUseCase = DeleteRecipe(repository);

  // Register online recipes services
  final fetchRecipeDataSource = FetchRecipeDataSourceImpl();
  final fetchRecipeRepository =
      FetchRepositoryImpl(fetchRecipeDataSource: fetchRecipeDataSource);
  final getFetchRecipeUsecase =
      GetFetchRecipeUsecase(fetchRepository: fetchRecipeRepository);

  // Register grocery services
  final groceryBox = Hive.box<GroceryModel>('grocery');
  final groceryLocalDataSource = GroceryLocalDataSourceImpl(groceryBox);
  final groceryRepository = GroceryRepositoryImpl(groceryLocalDataSource);
  final getGroceryUseCase = GetGroceryUsecase(groceryRepository);
  final addGroceryUseCase = AddGroceryUsecase(groceryRepository);
  final deleteGroceryUseCase = DeleteGroceryUsecase(groceryRepository);
  final updateGroceryUsecase = UpdateGroceryUsecase(groceryRepository);

  // Register to GetIt
  getIt.registerLazySingleton(() => getRecipesUseCase);
  getIt.registerLazySingleton(() => addRecipeUseCase);
  getIt.registerLazySingleton(() => deleteRecipeUseCase);
  getIt.registerLazySingleton(() => localDataSource);
  getIt.registerLazySingleton(() => getFetchRecipeUsecase);
  getIt.registerLazySingleton(() => getGroceryUseCase);
  getIt.registerLazySingleton(() => addGroceryUseCase);
  getIt.registerLazySingleton(() => deleteGroceryUseCase);
  getIt.registerLazySingleton(() => updateGroceryUsecase);
}
