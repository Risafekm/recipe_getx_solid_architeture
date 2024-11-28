import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipes_solid/features/grocery_items_listing/data/models/grocery_model.dart';
import 'package:recipes_solid/features/grocery_items_listing/domain/usecases/add_grocery_usecase.dart';
import 'package:recipes_solid/features/grocery_items_listing/domain/usecases/delete_grocery_usecase.dart';
import 'package:recipes_solid/features/grocery_items_listing/domain/usecases/get_grocery_usecase.dart';
import 'package:recipes_solid/features/grocery_items_listing/domain/usecases/update_grocery_usecase.dart';
import 'package:recipes_solid/features/grocery_items_listing/presentation/pages/grocery/grocery_screen.dart';
import 'core/dependency_injection/injection.dart';
import 'core/language_localization/localization.dart';
import 'core/theme/theme.dart';
import 'features/online_recipes/domain/usecases/get_fetch_recipe_usecase.dart';
import 'features/online_recipes/presentation/controller/fetch_recipe_controller.dart';
import 'features/online_recipes/presentation/pages/fetch_recipe_screen/fetch_recipe_screen.dart';
import 'features/own_recipes/data/models/recipe_model.dart';
import 'features/own_recipes/data/datasources/recipe_local_data_source.dart';
import 'features/own_recipes/domain/usecases/get_recipes.dart';
import 'features/own_recipes/domain/usecases/add_recipe.dart';
import 'features/own_recipes/domain/usecases/delete_recipe.dart';
import 'features/own_recipes/presentation/controller/recipe_controller.dart';
import 'features/own_recipes/presentation/pages/add_recipe_screen/add_recipe_screen.dart';
import 'features/own_recipes/presentation/pages/bottomnavigation/bottomnavigation.dart';
import 'features/own_recipes/presentation/pages/home_screen/home_screen.dart';
import 'features/own_recipes/presentation/pages/splash_screen/splash_screen.dart';
import 'features/grocery_items_listing/presentation/controller/grocery_controller.dart';

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

  // Set up the service locator
  setup();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
          getRecipesUseCase: getIt<GetRecipes>(),
          addRecipeUseCase: getIt<AddRecipe>(),
          deleteRecipeUseCase: getIt<DeleteRecipe>(),
          recipeService: getIt<RecipeLocalDataSourceImpl>(),
        ));

        // Inject FetchRecipeController dependencies
        Get.put(FetchRecipeController(
          getFetchRecipeUsecase: getIt<GetFetchRecipeUsecase>(),
        ));

        // Inject GroceryController dependencies
        Get.put(GroceryController(
          getGroceryUseCase: getIt<GetGroceryUsecase>(),
          addGroceryUseCase: getIt<AddGroceryUsecase>(),
          deleteGroceryUseCase: getIt<DeleteGroceryUsecase>(),
          updateGroceryUsecase: getIt<UpdateGroceryUsecase>(),
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
