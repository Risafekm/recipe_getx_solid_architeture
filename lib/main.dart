import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/language_localization/localization.dart';
import 'core/theme/theme.dart';
import 'data/models/recipe_model.dart';
import 'data/datasources/recipe_local_data_source.dart';
import 'data/repositories/recipe_repository_imp.dart';
import 'domain/usecases/get_recipes.dart';
import 'domain/usecases/add_recipe.dart';
import 'domain/usecases/delete_recipe.dart';
import 'presentation/controller/recipe_controller.dart';
import 'presentation/pages/add_recipe_screen/add_recipe_screen.dart';
import 'presentation/pages/bottomnavigation/bottomnavigation.dart';
import 'presentation/pages/home_screen/home_screen.dart';
import 'presentation/pages/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(RecipeModelAdapter());
  await Hive.openBox('language');
  // await Hive.deleteBoxFromDisk('recipes'); // Clears the 'recipes' box
  final recipeBox = await Hive.openBox<RecipeModel>('recipes'); // Reopen

  final localDataSource = RecipeLocalDataSourceImpl(recipeBox);
  final repository = RecipeRepositoryImpl(localDataSource);

  // Inject use cases
  final getRecipesUseCase = GetRecipes(repository);
  final addRecipeUseCase = AddRecipe(repository);
  final deleteRecipeUseCase = DeleteRecipe(repository);

  runApp(MyApp(
    getRecipesUseCase: getRecipesUseCase,
    addRecipeUseCase: addRecipeUseCase,
    deleteRecipeUseCase: deleteRecipeUseCase,
  ));
}

class MyApp extends StatelessWidget {
  final GetRecipes getRecipesUseCase;
  final AddRecipe addRecipeUseCase;
  final DeleteRecipe deleteRecipeUseCase;

  MyApp({
    required this.getRecipesUseCase,
    required this.addRecipeUseCase,
    required this.deleteRecipeUseCase,
  });

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('language');
    final localeString = box.get('locale', defaultValue: 'en_US');
    final localeParts = localeString.split('_');
    final locale =
        Locale(localeParts[0], localeParts.length > 1 ? localeParts[1] : '');

    return GetMaterialApp(
      locale: locale,
      translations: LocalizationServices(),
      theme: ThemeData(
        appBarTheme: MyTheme().appTheme,
      ),
      debugShowCheckedModeBanner: false,
      initialBinding: BindingsBuilder(() {
        Get.put(RecipeController(
          getRecipesUseCase: getRecipesUseCase,
          addRecipeUseCase: addRecipeUseCase,
          deleteRecipeUseCase: deleteRecipeUseCase,
        ));
      }),
      home: SplashScreen(),
      routes: {
        '/home': (context) => HomeScreen(),
        '/add': (context) => AddRecipeScreen(),
        '/bottom': (context) => BottomNavigator(),
      },
    );
  }
}
