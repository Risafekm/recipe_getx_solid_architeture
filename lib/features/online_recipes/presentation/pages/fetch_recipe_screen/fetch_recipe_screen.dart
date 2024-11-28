import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipes_solid/features/online_recipes/domain/entities/fetch_entity.dart';
import '../../controller/fetch_recipe_controller.dart';
import '../description_page/description_page.dart';

class FetchRecipeScreen extends StatelessWidget {
  final FetchRecipeController fetchController =
      Get.find<FetchRecipeController>();

  FetchRecipeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Set up dependencies for online recipes
    // final fetchRecipeDataSource = FetchRecipeDataSourceImpl();
    // final fetchRecipeRepository =
    //     FetchRepositoryImpl(fetchRecipeDataSource: fetchRecipeDataSource);
    // final getFetchRecipeUsecase =
    //     GetFetchRecipeUsecase(fetchRepository: fetchRecipeRepository);
    // var fetchController = Get.put(FetchRecipeController(
    //   getFetchRecipeUsecase: getFetchRecipeUsecase,
    // ));
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios),
        ),
        title: Text('recipe_appbar'.tr),
        automaticallyImplyLeading: false,
      ),
      body: Obx(() {
        if (fetchController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (fetchController.fetchList.isEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Center(
              child: Text(
                'recipes'.tr,
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }
        return ListView.builder(
          itemCount: fetchController.fetchList.length,
          itemBuilder: (context, index) {
            final FetchEntity recipe = fetchController.fetchList[index];
            return GestureDetector(
              onTap: () =>
                  Get.to(() => FetchDescriptionScreen(recipeModel: recipe)),
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16, top: 6),
                child: Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(8.0),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: recipe.imageUrl.isNotEmpty
                              ? Image.network(
                                  recipe.imageUrl,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.fill,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Container(
                                      height: 80,
                                      width: 80,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/no_image.png'),
                                            scale: .5,
                                            fit: BoxFit.fitHeight),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 80,
                                  width: 80,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    image: DecorationImage(
                                        image:
                                            AssetImage('assets/no_image.png'),
                                        scale: .5,
                                        fit: BoxFit.fitHeight),
                                  ),
                                ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0, top: 30),
                            child: Text(recipe.name,
                                style: const TextStyle(fontSize: 18)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
