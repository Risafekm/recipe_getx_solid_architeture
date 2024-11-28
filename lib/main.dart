import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipes_solid/features/grocery_items_listing/data/datasources/grocery_local_data_source.dart';
import 'package:recipes_solid/features/grocery_items_listing/data/models/grocery_model.dart';
import 'package:recipes_solid/features/grocery_items_listing/domain/usecases/add_grocery_usecase.dart';
import 'package:recipes_solid/features/grocery_items_listing/domain/usecases/delete_grocery_usecase.dart';
import 'package:recipes_solid/features/grocery_items_listing/domain/usecases/get_grocery_usecase.dart';
import 'package:recipes_solid/features/grocery_items_listing/domain/usecases/update_grocery_usecase.dart';
import 'package:recipes_solid/features/grocery_items_listing/presentation/pages/grocery/grocery_screen.dart';
import 'core/language_localization/localization.dart';
import 'core/theme/theme.dart';
import 'features/online_recipes/data/repositories/fetch_repository_impl.dart';
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
import 'features/grocery_items_listing/presentation/controller/grocery_controller.dart';
import 'features/grocery_items_listing/data/repositories/grocery_repository_impl.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive and register adapters
  try {
    await Hive.initFlutter();
    Hive.registerAdapter(RecipeModelAdapter());
    Hive.registerAdapter(GroceryModelAdapter());

    // Open all required boxes
    await Future.wait([
      Hive.openBox('language'),
      Hive.openBox<RecipeModel>('recipes'),
      Hive.openBox<GroceryModel>('grocery'),
    ]);
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

  // Set up dependencies for grocery items
  final groceryBox = Hive.box<GroceryModel>('grocery');

  final groceryLocalDataSource = GroceryLocalDataSourceImpl(groceryBox);
  final groceryRepository = GroceryRepositoryImpl(groceryLocalDataSource);
  final getGroceryUseCase = GetGroceryUsecase(groceryRepository);
  final addGroceryUseCase = AddGroceryUsecase(groceryRepository);
  final deleteGroceryUseCase = DeleteGroceryUsecase(groceryRepository);
  final updateGroceryUsecase = UpdateGroceryUsecase(groceryRepository);

  runApp(MyApp(
    getRecipesUseCase: getRecipesUseCase,
    addRecipeUseCase: addRecipeUseCase,
    deleteRecipeUseCase: deleteRecipeUseCase,
    recipeService: localDataSource,
    getFetchRecipeUsecase: getFetchRecipeUsecase,
    getGroceryUseCase: getGroceryUseCase,
    addGroceryUseCase: addGroceryUseCase,
    deleteGroceryUseCase: deleteGroceryUseCase,
    updateGroceryUsecase: updateGroceryUsecase,
  ));
}

class MyApp extends StatelessWidget {
  final GetRecipes getRecipesUseCase;
  final AddRecipe addRecipeUseCase;
  final DeleteRecipe deleteRecipeUseCase;
  final RecipeLocalDataSourceImpl recipeService;
  final GetFetchRecipeUsecase getFetchRecipeUsecase;
  final GetGroceryUsecase getGroceryUseCase;
  final AddGroceryUsecase addGroceryUseCase;
  final DeleteGroceryUsecase deleteGroceryUseCase;
  final UpdateGroceryUsecase updateGroceryUsecase;

  const MyApp({
    Key? key,
    required this.getRecipesUseCase,
    required this.addRecipeUseCase,
    required this.deleteRecipeUseCase,
    required this.recipeService,
    required this.getFetchRecipeUsecase,
    required this.getGroceryUseCase,
    required this.addGroceryUseCase,
    required this.deleteGroceryUseCase,
    required this.updateGroceryUsecase,
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

        // Inject GroceryController dependencies
        Get.put(GroceryController(
          getGroceryUseCase: getGroceryUseCase,
          addGroceryUseCase: addGroceryUseCase,
          deleteGroceryUseCase: deleteGroceryUseCase,
          updateGroceryUsecase: updateGroceryUsecase,
        ));
      }),
      home: const SplashScreen(),
      routes: {
        '/fetch': (context) => FetchRecipeScreen(),
        '/home': (context) => HomeScreen(),
        '/add': (context) => AddRecipeScreen(),
        '/grocery': (context) => GroceryScreen(),
        '/bottom': (context) => const BottomNavigator(),
      },
    );
  }
}
