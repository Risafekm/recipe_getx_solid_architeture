import 'package:get/get.dart';
import 'package:recipes_solid/features/own_recipes/data/datasources/recipe_local_data_source.dart';
import 'package:recipes_solid/features/own_recipes/data/models/recipe_model.dart';
import '../../domain/entities/recipe.dart';
import '../../domain/usecases/get_recipes.dart';
import '../../domain/usecases/add_recipe.dart';
import '../../domain/usecases/delete_recipe.dart';

class RecipeController extends GetxController {
  final GetRecipes getRecipesUseCase;
  final AddRecipe addRecipeUseCase;
  final DeleteRecipe deleteRecipeUseCase;
  final RecipeLocalDataSourceImpl recipeService;

  var recipes = <Recipe>[].obs;

  RecipeController({
    required this.getRecipesUseCase,
    required this.addRecipeUseCase,
    required this.deleteRecipeUseCase,
    required this.recipeService,
  });

  @override
  void onInit() {
    super.onInit();
    loadRecipes();
  }

  void loadRecipes() async {
    recipes.value = await getRecipesUseCase.call();
  }

  void addRecipe(Recipe recipe) async {
    await addRecipeUseCase.call(recipe);
    loadRecipes(); // Reload the list after adding
  }

// Save the recipes to Hive
  Future<void> saveRecipesToHive() async {
    // Clear existing Hive data before saving the updated list
    await recipeService.recipeBox.clear();

    // Save each recipe by converting it to RecipeModel
    for (var recipe in recipes) {
      final recipeModel = RecipeModel.fromEntity(recipe);
      await recipeService.addRecipe(recipeModel);
    }
  }

  void deleteRecipe(String id) async {
    await deleteRecipeUseCase.call(id);
    loadRecipes(); // Reload the list after deletion
  }
}
