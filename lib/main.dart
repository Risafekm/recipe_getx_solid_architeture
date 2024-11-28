import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipes_solid/features/online_recipes/data/repositories/fetch_repository_impl.dart';
import 'core/language_localization/localization.dart';
import 'core/theme/theme.dart';
import 'features/grocery_items_listing/presentation/pages/grocery/grocery_screen.dart';
import 'features/online_recipes/data/datasources/fetch_recipe_data_source.dart';
import 'features/online_recipes/domain/usecases/get_fetch_recipe_usecase.dart';
import 'features/online_recipes/presentation/controller/fetch_recipe_controller.dart';
import 'features/online_recipes/presentation/pages/fetch_recipe_screen/fetch_recipe_screen.dart';
import 'features/own_recipes/data/models/recipe_model.dart';
import 'features/own_recipes/data/datasources/recipe_local_data_source.dart';
import 'features/own_recipes/data/repositories/recipe_repository_imp.dart';
import 'features/own_recipes/domain/usecases/get_recipes.dart';
import 'features/own_recipes/domain/usecases/add_recipe.dart';
import 'features/own_recipes/domain/usecases/delete_recipe.dart';
import 'features/own_recipes/presentation/controller/recipe_controller.dart';
import 'features/own_recipes/presentation/pages/add_recipe_screen/add_recipe_screen.dart';
import 'features/own_recipes/presentation/pages/bottomnavigation/bottomnavigation.dart';
import 'features/own_recipes/presentation/pages/home_screen/home_screen.dart';
import 'features/own_recipes/presentation/pages/splash_screen/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive and register adapters
  try {
    await Hive.initFlutter();
    Hive.registerAdapter(RecipeModelAdapter());
    await Hive.openBox('language');
    await Hive.openBox<RecipeModel>('recipes');
  } catch (e) {
    debugPrint("Error initializing Hive: $e");
  }

  // Set up dependencies for own recipes
  final recipeBox = Hive.box<RecipeModel>('recipes');
  final localDataSource = RecipeLocalDataSourceImpl(recipeBox);
  final repository = RecipeRepositoryImpl(localDataSource);

  final getRecipesUseCase = GetRecipes(repository);
  final addRecipeUseCase = AddRecipe(repository);
  final deleteRecipeUseCase = DeleteRecipe(repository);

  // Set up dependencies for online recipes
  final fetchRecipeDataSource = FetchRecipeDataSourceImpl();
  final fetchRecipeRepository =
      FetchRepositoryImpl(fetchRecipeDataSource: fetchRecipeDataSource);
  final getFetchRecipeUsecase =
      GetFetchRecipeUsecase(fetchRepository: fetchRecipeRepository);

  runApp(MyApp(
    getRecipesUseCase: getRecipesUseCase,
    addRecipeUseCase: addRecipeUseCase,
    deleteRecipeUseCase: deleteRecipeUseCase,
    recipeService: localDataSource,
    getFetchRecipeUsecase: getFetchRecipeUsecase,
  ));
}

class MyApp extends StatelessWidget {
  final GetRecipes getRecipesUseCase;
  final AddRecipe addRecipeUseCase;
  final DeleteRecipe deleteRecipeUseCase;
  final RecipeLocalDataSourceImpl recipeService;
  final GetFetchRecipeUsecase getFetchRecipeUsecase;

  const MyApp({
    Key? key,
    required this.getRecipesUseCase,
    required this.addRecipeUseCase,
    required this.deleteRecipeUseCase,
    required this.recipeService,
    required this.getFetchRecipeUsecase,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Retrieve and set the locale
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
        // Inject RecipeController dependencies
        Get.put(RecipeController(
          getRecipesUseCase: getRecipesUseCase,
          addRecipeUseCase: addRecipeUseCase,
          deleteRecipeUseCase: deleteRecipeUseCase,
          recipeService: recipeService,
        ));

        // Inject FetchRecipeController dependencies
        Get.put(FetchRecipeController(
          getFetchRecipeUsecase: getFetchRecipeUsecase,
        ));
      }),
      home: SplashScreen(),
      routes: {
        '/fetch': (context) => FetchRecipeScreen(),
        '/home': (context) => HomeScreen(),
        '/add': (context) => AddRecipeScreen(),
        '/grocery': (context) => GroceryScreen(),
        '/bottom': (context) => BottomNavigator(),
      },
    );
  }
}
