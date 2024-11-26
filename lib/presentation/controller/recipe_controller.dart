import 'package:get/get.dart';
import '../../domain/entities/recipe.dart';
import '../../domain/usecases/get_recipes.dart';
import '../../domain/usecases/add_recipe.dart';
import '../../domain/usecases/delete_recipe.dart';

class RecipeController extends GetxController {
  final GetRecipes getRecipesUseCase;
  final AddRecipe addRecipeUseCase;
  final DeleteRecipe deleteRecipeUseCase;

  var recipes = <Recipe>[].obs;

  RecipeController({
    required this.getRecipesUseCase,
    required this.addRecipeUseCase,
    required this.deleteRecipeUseCase,
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

  void deleteRecipe(String id) async {
    await deleteRecipeUseCase.call(id);
    loadRecipes(); // Reload the list after deletion
  }
}
