import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipes_solid/features/online_recipes/domain/entities/fetch_entity.dart';
import 'package:recipes_solid/features/online_recipes/domain/usecases/get_fetch_recipe_usecase.dart';

class FetchRecipeController extends GetxController {
  RxList<FetchEntity> fetchList = <FetchEntity>[].obs;
  RxBool isLoading = false.obs;
  GetFetchRecipeUsecase getFetchRecipeUsecase;

  FetchRecipeController({required this.getFetchRecipeUsecase});

  @override
  void onInit() {
    fetchRecipes();
    super.onInit();
  }

  void fetchRecipes() async {
    try {
      isLoading.value = true;
      final result = await getFetchRecipeUsecase();
      fetchList.value = result; // No mapping needed
    } catch (error) {
      debugPrint('Error fetching recipes: $error');
    } finally {
      isLoading.value = false;
    }
  }
}
